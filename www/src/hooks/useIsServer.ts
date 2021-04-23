import { useEffect, useState } from "react";

export const useIsServer = (): boolean => {
  const [isServer, setIsServer] = useState(true);

  useEffect(() => setIsServer(false), []);

  return isServer;
};
