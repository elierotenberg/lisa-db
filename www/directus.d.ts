export interface Accommodation {
  accommodation_id: number;
  name: string;
  description?: string;
  accommodation_index?: number;
}

export interface AccommodationResearchEvidence {
  accommodation_id: number;
  research_evidence_id: number;
}

export interface Alias {
  alias_id: number;
  task_id?: number;
  name: string;
}

export interface AssessmentReference {
  assessment_reference_id: number;
  title: string;
  link?: string;
  pub_med_id?: number;
}

export interface AssessmentReferenceAuthor {
  assessment_reference_id: number;
  author_id: number;
  rank?: number;
}

export interface Author {
  author_id: number;
  first_initial?: string;
  middle_initial?: string;
  surname: string;
}

export interface BehaviourAccommodation {
  accommodation_id: number;
  behaviour_id: number;
}

export interface BehaviourGuide {
  guide_id: number;
  behaviour_id: number;
}

export interface BehaviourIntervention {
  intervention_id: number;
  behaviour_id: number;
}

export interface BehaviourQuestionnaire {
  questionnaire_id: number;
  behaviour_id: number;
}

export interface BehaviourTechnology {
  technology_id: number;
  behaviour_id: number;
}

export interface Disorder {
  disorder_id: number;
  name: string;
  disorder_category_id?: number;
  disorder_subcategory_id?: number;
  icd_9_cm?: number;
  icd_10_cm?: number;
}

export interface DisorderAccommodation {
  accommodation_id: number;
  disorder_id: number;
}

export interface DisorderCategory {
  disorder_category_id: number;
  name: string;
}

export interface DisorderCategoryAccommodation {
  accommodation_id: number;
  disorder_category_id: number;
}

export interface DisorderCategoryIntervention {
  intervention_id: number;
  disorder_category_id: number;
}

export interface DisorderCategoryTechnology {
  technology_id: number;
  disorder_category_id: number;
}

export interface DisorderIntervention {
  intervention_id: number;
  disorder_id: number;
}

export interface DisorderReference {
  disorder_reference_id: number;
  title: string;
}

export interface DisorderReferenceAuthor {
  disorder_reference_id: number;
  author_id: number;
  rank?: number;
}

export interface DisorderSignSymptom {
  disorder_id: number;
  sign_symptom_id: number;
}

export interface DisorderSubcategory {
  disorder_subcategory_id: number;
  name: string;
}

export interface DisorderTechnology {
  technology_id: number;
  disorder_id: number;
}

export interface Guide {
  guide_id: number;
  title: string;
  link: string;
  publisher: string;
  guide_type_id: number;
  guide_reference_id?: number;
}

export interface GuideAccommodation {
  accommodation_id: number;
  guide_id: number;
}

export interface GuideAudience {
  audience_id: number;
  guide_id: number;
}

export interface GuideAuthor {
  author_id: number;
  guide_id: number;
  rank?: number;
}

export interface GuideDisorder {
  disorder_id: number;
  guide_id: number;
}

export interface GuideDisorderCategory {
  disorder_category_id: number;
  guide_id: number;
}

export interface GuideIntervention {
  intervention_id: number;
  guide_id: number;
}

export interface GuideReference {
  guide_reference_id: number;
  title?: string;
  link?: string;
  pub_med_id?: number;
}

export interface GuideTechnology {
  technology_id: number;
  guide_id: number;
}

export interface GuideType {
  guide_type_id: number;
  name: string;
}

export interface Icd10Cm {
  icd_10_cm_id: number;
  code: string;
}

export interface Icd9Cm {
  icd_9_cm_id: number;
  code: string;
}

export interface Intervention {
  intervention_id: number;
  name?: string;
  description?: string;
  intervention_index?: number;
}

export interface InterventionResearchEvidence {
  intervention_id: number;
  research_evidence_id: number;
}

export interface LanguageSource {
  language_source_id: number;
}

export interface NeutralConstruct {
  neutral_construct_id: number;
  name: string;
}

export interface Question {
  question_id: number;
  questionnaire_id: number;
  paper_instruction_preamble?: string;
  digital_instruction_preamble?: string;
  paper_instruction?: string;
  digital_instruction?: string;
  question_context: string;
  response_type_id: number;
  response_option_id?: number;
}

export interface Questionnaire {
  questionnaire_id: number;
  title: string;
  link?: string;
  description?: string;
  abbreviation?: string;
  age_max?: number;
  age_min?: number;
  number_of_questions?: number;
  minutes_to_complete?: number;
  license_id: number;
  assessment_reference_id?: number;
}

export interface QuestionnaireAuthor {
  author_id: number;
  questionnaire_id: number;
  rank?: number;
}

export interface QuestionnaireDisorder {
  questionnaire_id: number;
  disorder_id: number;
}

export interface QuestionnaireDisorderCategory {
  questionnaire_id: number;
  disorder_category_id: number;
}

export interface QuestionnaireLanguageSource {
  questionnaire_id: number;
  language_source_id: number;
}

export interface QuestionnaireRespondent {
  respondent_id: number;
  questionnaire_id: number;
}

export interface QuestionnaireSignSymptom {
  questionnaire_id: number;
  sign_symptom_id: number;
}

export interface QuestionnaireSubject {
  subject_id: number;
  questionnaire_id: number;
}

export interface ResearchEvidence {
  research_evidence_id: number;
  context: string;
}

export interface ResourcePeopleAudience {
  audience_id: number;
  person: string;
}

export interface Respondent {
  respondent_id: number;
}

export interface ResponseOption {
  response_option_id: number;
  option_context: string;
}

export interface ResponseType {
  response_type_id: number;
  type: string;
  response_type_definition: string;
}

export interface SignSymptom {
  sign_symptom_id: number;
  name: string;
  underlying_behavior?: string;
  disorder_reference_id: number;
}

export interface SignSymptomAccommodation {
  accommodation_id: number;
  sign_symptom_id: number;
}

export interface SignSymptomExample {
  sign_symptom_example_id: number;
  name: string;
}

export interface SignSymptomIntervention {
  intervention_id: number;
  sign_symptom_id: number;
}

export interface SignSymptomNeutralConstruct {
  sign_symptom_id: number;
  neutral_construct_id: number;
}

export interface SignSymptomTechnology {
  technology_id: number;
  sign_symptom_id: number;
}

export interface SignSymptomwithExample {
  sign_symptom_id: number;
  sign_symptom_example_id: number;
}

export interface StateDomainBehaviour {
  behaviour_id: number;
  behaviour: string;
}

export interface Subject {
  subject_id: number;
}

export interface Task {
  task_id: number;
  name: string;
  description?: string;
  assessment_reference_id: number;
}

export interface Technology {
  technology_id: number;
  name?: string;
  description?: string;
  link?: string;
}

export interface TechnologyResearchEvidence {
  technology_id: number;
  research_evidence_id: number;
}

export type Collections = {
  accommodations: Accommodation;
  accommodation_research_evidences: AccommodationResearchEvidence;
  aliass: Alias;
  assessment_references: AssessmentReference;
  assessment_reference_authors: AssessmentReferenceAuthor;
  authors: Author;
  behaviour_accommodations: BehaviourAccommodation;
  behaviour_guides: BehaviourGuide;
  behaviour_interventions: BehaviourIntervention;
  behaviour_questionnaires: BehaviourQuestionnaire;
  behaviour_technologys: BehaviourTechnology;
  disorders: Disorder;
  disorder_accommodations: DisorderAccommodation;
  disorder_categorys: DisorderCategory;
  disorder_category_accommodations: DisorderCategoryAccommodation;
  disorder_category_interventions: DisorderCategoryIntervention;
  disorder_category_technologys: DisorderCategoryTechnology;
  disorder_interventions: DisorderIntervention;
  disorder_references: DisorderReference;
  disorder_reference_authors: DisorderReferenceAuthor;
  disorder_sign_symptoms: DisorderSignSymptom;
  disorder_subcategorys: DisorderSubcategory;
  disorder_technologys: DisorderTechnology;
  guides: Guide;
  guide_accommodations: GuideAccommodation;
  guide_audiences: GuideAudience;
  guide_authors: GuideAuthor;
  guide_disorders: GuideDisorder;
  guide_disorder_categorys: GuideDisorderCategory;
  guide_interventions: GuideIntervention;
  guide_references: GuideReference;
  guide_technologys: GuideTechnology;
  guide_types: GuideType;
  icd_10_cms: Icd10Cm;
  icd_9_cms: Icd9Cm;
  interventions: Intervention;
  intervention_research_evidences: InterventionResearchEvidence;
  language_sources: LanguageSource;
  neutral_constructs: NeutralConstruct;
  questions: Question;
  questionnaires: Questionnaire;
  questionnaire_authors: QuestionnaireAuthor;
  questionnaire_disorders: QuestionnaireDisorder;
  questionnaire_disorder_categorys: QuestionnaireDisorderCategory;
  questionnaire_language_sources: QuestionnaireLanguageSource;
  questionnaire_respondents: QuestionnaireRespondent;
  questionnaire_sign_symptoms: QuestionnaireSignSymptom;
  questionnaire_subjects: QuestionnaireSubject;
  research_evidences: ResearchEvidence;
  resource_people_audiences: ResourcePeopleAudience;
  respondents: Respondent;
  response_options: ResponseOption;
  response_types: ResponseType;
  sign_symptoms: SignSymptom;
  sign_symptom_accommodations: SignSymptomAccommodation;
  sign_symptom_examples: SignSymptomExample;
  sign_symptom_interventions: SignSymptomIntervention;
  sign_symptom_neutral_constructs: SignSymptomNeutralConstruct;
  sign_symptom_technologys: SignSymptomTechnology;
  sign_symptom_with_examples: SignSymptomwithExample;
  state_domain_behaviours: StateDomainBehaviour;
  subjects: Subject;
  tasks: Task;
  technologys: Technology;
  technology_research_evidences: TechnologyResearchEvidence;
};
