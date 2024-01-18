import styles from './PropertyCard.module.scss';
import PlaceholderImg from '../../../../assets/placeholder_image.jpg';
import { Property, PropertyType } from '../../../../services/property.type';
import { CONFIG } from '../../../../utils/config';
import { useEffect, useState } from 'react';

type Props = {
  property: Property;
};

const typeTranslation: {
  [K in PropertyType]: string;
} = {
  apartment: 'Appartement',
  house: 'Maison',
};

const PropertyCard = ({ property }: Props) => {
  const [isFavorite, setIsFavorite] = useState(false);
  const [image, setImage] = useState('');

  useEffect(() => {
    if (!property.imagesPaths.length) {
      setImage(PlaceholderImg);
      return;
    }
    setImage(CONFIG.PUBLIC_CONTENT_URL + '/' + property.imagesPaths[0]);
  }, [property.imagesPaths]);

  return (
    <div className={styles.card}>
      <div className={styles.imageLayout}>
        <div className={styles.image}>
          <img
            src={image}
            alt="Home preview"
            onError={() => setImage(PlaceholderImg)}
          />
        </div>

        <div className={styles.imageBottomSection}>
          <span className={styles.price}>{property.price}€</span>

          <div
            className={styles.favoriteIcon}
            onClick={() => setIsFavorite(!isFavorite)}>
            <i
              className={`${isFavorite ? 'fa-solid' : 'fa-regular'} fa-heart`}
            />
          </div>
        </div>
      </div>

      <h1 className={styles.name}>{property.name}</h1>
      <div className={styles.location}>
        <i className="fa-solid fa-location-dot"></i>

        <span>{property.address}</span>
      </div>

      <div className={styles.infoGroup}>
        <div className={styles.info}>
          <i className="fa-solid fa-house" />
          <span>
            {property.roomsCount} chambre{property.roomsCount > 1 ? 's' : ''}
          </span>
        </div>

        <div className={styles.info}>
          <i className="fa-solid fa-building" />
          <span>{typeTranslation[property.type]}</span>
        </div>

        <div className={styles.info}>
          <i className="fa-solid fa-expand" />
          <span>{property.surface}m²</span>
        </div>
      </div>
    </div>
  );
};

export default PropertyCard;
