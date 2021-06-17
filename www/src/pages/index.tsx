import { FunctionComponent } from "react";

import { lorem } from "../lib/MockData";

const IndexPage: FunctionComponent = () => <div>{lorem(100)}</div>;

export default IndexPage;
