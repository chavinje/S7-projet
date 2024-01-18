import Lottie from 'react-lottie';
import loading from './loading.json';

type Props = {
  type: 'loading';
  width: string;
};

const Lotties = (props: Props) => {
  return (
    <div style={{ width: props.width }}>
      {props.type === 'loading' && (
        <Lottie
          isClickToPauseDisabled
          options={{ animationData: loading, autoplay: true, loop: true }}
        />
      )}
    </div>
  );
  return <div>Lotties</div>;
};

export default Lotties;
