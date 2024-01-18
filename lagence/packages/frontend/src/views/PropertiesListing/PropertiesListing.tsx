import { useEffect, useState } from 'react';
import FiltersSidebar, {
  PropertyFilters,
} from './components/FiltersSidebar/FiltersSidebar';
import PropertyCard from './components/PropertyCard/PropertyCard';
import styles from './PropertiesListing.module.scss';
import Button from '../../components/Button/Button';
import Breadcrumb from '../../components/Breadcrumb/Breadcrumb';
import { useQuery } from 'react-query';
import { propertyService } from '../../services';
import { useSearchParams } from 'react-router-dom';

const breadcrumbPaths = [
  { name: 'Accueil', path: '/' },
  { name: 'Locations', path: '/properties' },
];

const PropertiesListing = () => {
  const [isSidebarShown, setIsSidebarShown] = useState(false);
  const [filters, setFilters] = useState<PropertyFilters>();
  const [searchParams, setSearchParams] = useSearchParams();

  // Store filters in URL (react router) & load them on page load
  useEffect(() => {
    if (!filters) {
      const rooms = searchParams.get('rooms');
      const type = searchParams.get('type');
      const price = searchParams.get('price');

      if (!rooms && !type && !price) return;

      setFilters({
        rooms: rooms as PropertyFilters['rooms'],
        type: type?.split(',') as PropertyFilters['type'],
        price: price
          ?.split(',')
          .map((price) => parseInt(price)) as PropertyFilters['price'],
      });
    } else if (filters) {
      const params = new URLSearchParams();
      params.set('rooms', filters.rooms);
      params.set('type', filters.type.join(','));
      params.set('price', filters.price.join(','));

      setSearchParams(params);
    }
  }, [filters]);

  const {
    data: properties,
    isLoading: propertiesLoading,
    isSuccess: propertiesLoaded,
  } = useQuery('properties', propertyService.getAll);

  // Apply filters to properties
  const filteredProperties = filters
    ? properties?.filter((property) => {
        if (filters?.rooms !== 'all') {
          if (filters?.rooms === 'onePlus' && property.roomsCount < 1)
            return false;
          if (filters?.rooms === 'twoPlus' && property.roomsCount < 2)
            return false;
          if (filters?.rooms === 'threePlus' && property.roomsCount < 3)
            return false;
          if (filters?.rooms === 'fourPlus' && property.roomsCount < 4)
            return false;
        }

        if (filters?.type.length && !filters?.type.includes(property.type))
          return false;

        if (
          property.price < filters?.price[0] ||
          property.price > filters?.price[1]
        )
          return false;

        return true;
      })
    : properties;

  return (
    <>
      <div className={styles.listHeader}>
        <Breadcrumb paths={breadcrumbPaths} />

        <Button
          value="Filtres"
          onClick={() => setIsSidebarShown(true)}
          type="primary"
          icon={<i className="fa-solid fa-filter" />}
          className={styles.filtersButton}
        />
      </div>

      <div className={styles.container}>
        <FiltersSidebar
          isShown={isSidebarShown}
          onRequestClose={() => setIsSidebarShown(false)}
          filters={filters}
          onValidate={(filters) => setFilters(filters)}
        />

        <div className={styles.propertiesGrid}>
          {propertiesLoading ? (
            <div className={styles.message}>Chargement...</div>
          ) : propertiesLoaded ? (
            filteredProperties!.length > 0 ? (
              filteredProperties!.map((property) => (
                <PropertyCard key={property.id} property={property} />
              ))
            ) : (
              <div className={styles.message}>
                Aucune propriété ne correspond à vos critères
              </div>
            )
          ) : (
            <div className={styles.message}>
              Erreur lors du chargement des propriétés
            </div>
          )}
        </div>
      </div>
    </>
  );
};

export default PropertiesListing;
