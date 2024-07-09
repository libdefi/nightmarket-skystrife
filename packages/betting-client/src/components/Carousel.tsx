// src/components/Carousel.tsx
import React from "react";
import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import { useNavigate } from "react-router-dom";
const images = [
  {
    src: "/keyMatch/keyMatch01.png",
    link: "/0x0000000000000000000000000000000000000000000000000000000000000001",
  },
  {
    src: "/keyMatch/keyMatch02.png",
    link: "/0x0000000000000000000000000000000000000000000000000000000000000002",
  },
  {
    src: "/keyMatch/keyMatch03.png",
    link: "/0x0000000000000000000000000000000000000000000000000000000000000003",
  },
  {
    src: "/keyMatch/keyMatch04.png",
    link: "/0x0000000000000000000000000000000000000000000000000000000000000004",
  },
];

const Carousel: React.FC = () => {
  const navigate = useNavigate();
  const handleImageClick = (link: string) => {
    navigate(`/round${link}`);
  };

  const settings = {
    className: "center",
    centerMode: true,
    infinite: true,
    centerPadding: "60px",
    slidesToShow: 3,
    speed: 500,
    autoplay: true,
    autoplaySpeed: 2000, // Set to move every 2 seconds.
    arrows: false,
    responsive: [
      {
        breakpoint: 768,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1,
          centerMode: false,
        },
      },
    ],
  };

  return (
    <div className="carousel-container">
      <Slider {...settings}>
        {images.map((image, idx) => (
          <div key={idx} onClick={() => handleImageClick(image.link)} className="px-2">
            <img src={image.src} alt={`Slide ${idx + 1}`} className="w-full h-auto" />
          </div>
        ))}
      </Slider>
    </div>
  );
};

export default Carousel;
