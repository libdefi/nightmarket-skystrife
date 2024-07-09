import { HOW_TO_PLAY_URL } from "../../links";
import { ClickWrapper } from "../Theme/ClickWrapper";
import { Card } from "../Theme/SkyStrife/Card";

export function TutorialButton() {
  return (
    <ClickWrapper>
      <Card primary className="w-[40px] h-[40px] p-2">
        <a href={HOW_TO_PLAY_URL} target="_blank" rel="noreferrer">
          <div className="flex flex-row items-center">
            <svg width="24" height="24" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path
                d="M10 3.04201C8.35161 1.56337 6.2144 0.746952 4 0.750009C2.948 0.750009 1.938 0.930009 1 1.26201V15.512C1.96362 15.172 2.97816 14.9989 4 15C6.305 15 8.408 15.867 10 17.292M10 3.04201C11.6483 1.56328 13.7856 0.746857 16 0.750009C17.052 0.750009 18.062 0.930009 19 1.26201V15.512C18.0364 15.172 17.0218 14.9989 16 15C13.7856 14.997 11.6484 15.8134 10 17.292M10 3.04201V17.292"
                stroke="#5D5D4C"
                strokeWidth="1.5"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </svg>
          </div>
        </a>
      </Card>
    </ClickWrapper>
  );
}
