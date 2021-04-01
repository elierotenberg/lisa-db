import type { AppProps } from "next/app";
import React, { FunctionComponent, useEffect, useState } from "react";
import { useRouter } from "next/router";
import { MainNavBar } from "../components/MainNavBar/MainNavBar";
import { MdxProvider } from "../components/MdxProvider/MdxProvider";
import { ChakraProvider } from "../components/ChakraProvider/ChakraProvider";
import { MainContainer } from "../components/MainContainer/MainContainer";

const App: FunctionComponent<AppProps> = ({ Component, pageProps }) => {
  const [searchQuery, setSearchQuery] = useState("");
  const { asPath } = useRouter();
  useEffect(() => {
    setSearchQuery("");
  }, [asPath]);
  return (
    <ChakraProvider>
      <MdxProvider>
        <MainNavBar searchQuery={searchQuery} setSearchQuery={setSearchQuery} />
        <MainContainer searchQuery={searchQuery}>
          <Component {...pageProps} />
        </MainContainer>
      </MdxProvider>
    </ChakraProvider>
  );
};

export default App;
