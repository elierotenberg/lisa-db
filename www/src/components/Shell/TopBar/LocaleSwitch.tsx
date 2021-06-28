import { Radio, RadioGroup, Stack } from "@chakra-ui/react";
import React, { FunctionComponent } from "react";

export const LocaleSwitch: FunctionComponent = () => {
  const [value, setValue] = React.useState(`1`);
  return (
    <RadioGroup onChange={setValue} value={value}>
      <Stack direction="row">
        <Radio value="1" colorScheme="teal">
          EN
        </Radio>
        <Radio value="2" colorScheme="teal">
          FR
        </Radio>
        <Radio value="3" colorScheme="teal">
          PT
        </Radio>
      </Stack>
    </RadioGroup>
  );
};
