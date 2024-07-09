import React from "react";

const NotFound: React.FC = () => {
  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gray-100">
      <h1 className="text-4xl font-bold text-red-600">404 - Not Found</h1>
      <p className="mt-4 text-lg text-gray-600">The page you are looking for does not exist.</p>
      <a href="/" className="mt-6 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
        Go to Home
      </a>
    </div>
  );
};

export default NotFound;
