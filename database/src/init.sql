CREATE TABLE disorder (
  id int PRIMARY KEY IDENTITY,
  disorder_name text NOT NULL UNIQUE,
  disorder_category_index int NOT NULL REFERENCES disorder_category (id),
  disorder_subcategory_index int NOT NULL REFERENCES disorder_subcategory (id),
  icd_9_cm text REFERENCES icd_9_cm (id),
  icd_10_cm text REFERENCES icd_10_cm (id)
);

