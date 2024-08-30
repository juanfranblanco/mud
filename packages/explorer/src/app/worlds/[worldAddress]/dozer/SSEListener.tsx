"use client";

import React, { useEffect, useState } from "react";

const DOZER_URL = "https://redstone2.dozer.skystrife.xyz";
const DOZER_ADDRESS = "0xf75b1b7bdb6932e487c4aa8d210f4a682abeacf0";

const SSEListener = () => {
  const [data, setData] = useState([]);

  useEffect(() => {
    const eventSource = new EventSource(
      `${DOZER_URL}/q-live?address=${DOZER_ADDRESS}&query=select+entityId+from+Position+limit+10`,
    );

    eventSource.onmessage = (event) => {
      const newData = JSON.parse(event.data);
      setData((prevData) => [...prevData, newData]);
    };

    eventSource.onerror = (error) => {
      console.error("EventSource failed:", error);
      eventSource.close();
    };

    return () => {
      eventSource.close();
    };
  }, []);

  return (
    <div>
      <h2>Dozer updates:</h2>
      <ul>
        {data.map((item, index) => (
          <li key={index}>{JSON.stringify(item)}</li>
        ))}
      </ul>
    </div>
  );
};

export default SSEListener;
