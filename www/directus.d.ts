export interface Accommodation {
  accommodation_id: number;
  name: string;
  description?: string;
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
  author_first_initial: string;
  author_middle_initial: string;
  author_surname: string;
  rank?: number;
}

export interface Author {
  first_initial: string;
  middle_initial: string;
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
  icd_9_cm?: string;
  icd_10_cm?: string;
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
  author_first_initial: string;
  author_middle_initial: string;
  author_surname: string;
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
  author_first_initial: string;
  author_middle_initial: string;
  author_surname: string;
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

export interface GuideGuideType {
  guide_type_id: number;
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

export interface Intervention {
  intervention_id: number;
  name?: string;
  description?: string;
}

export interface InterventionResearchEvidence {
  intervention_id: number;
  research_evidence_id: number;
}

export interface LanguageSource {
  language_source_id: number;
  name: string;
}

export interface LisaDomain {
  domain_id: string;
}

export interface LisaDomainLocale {
  domain_id: string;
  locale_id: string;
  name: string;
  description: string;
}

export interface LisaGuide {
  lisa_guide_id: string;
}

export interface LisaGuideLocale {
  lisa_guide_id: string;
  locale_id: string;
  name?: string;
  description?: string;
}

export interface LisaSubdomain {
  subdomain_id: string;
  domain_id: string;
}

export interface LisaSubdomainGuide {
  subdomain_id: string;
  lisa_guide_id: string;
  rank: number;
}

export interface LisaSubdomainGuideLocale {
  rank: number;
  locale_id: string;
}

export interface LisaSubdomainLocale {
  subdomain_id: string;
  locale_id: string;
  name: string;
  description: string;
}

export interface Locale {
  locale_id: string;
  name: string;
}

export interface NeutralConstruct {
  name: string;
}

export interface Question {
  question_id: number;
  questionnaire_id?: number;
  paper_instruction_preamble?: string;
  digital_instruction_preamble?: string;
  paper_instruction?: string;
  digital_instruction?: string;
  question_context: string;
  response_option?: string;
}

export interface QuestionResponseType {
  response_type_id: number;
  question_id: number;
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
  language_source_id: number;
}

export interface QuestionnaireAssessmentReference {
  assessment_reference_id: number;
  questionnaire_id: number;
}

export interface QuestionnaireAuthor {
  author_first_initial: string;
  author_middle_initial: string;
  author_surname: string;
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

export interface QuestionnaireLanguageNotMhdb {
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
  name: string;
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
  accommodation: Accommodation;
  accommodation_research_evidence: AccommodationResearchEvidence;
  alias: Alias;
  assessment_reference: AssessmentReference;
  assessment_reference_author: AssessmentReferenceAuthor;
  author: Author;
  behaviour_accommodation: BehaviourAccommodation;
  behaviour_guide: BehaviourGuide;
  behaviour_intervention: BehaviourIntervention;
  behaviour_questionnaire: BehaviourQuestionnaire;
  behaviour_technology: BehaviourTechnology;
  disorder: Disorder;
  disorder_accommodation: DisorderAccommodation;
  disorder_category: DisorderCategory;
  disorder_category_accommodation: DisorderCategoryAccommodation;
  disorder_category_intervention: DisorderCategoryIntervention;
  disorder_category_technology: DisorderCategoryTechnology;
  disorder_intervention: DisorderIntervention;
  disorder_reference: DisorderReference;
  disorder_reference_author: DisorderReferenceAuthor;
  disorder_sign_symptom: DisorderSignSymptom;
  disorder_subcategory: DisorderSubcategory;
  disorder_technology: DisorderTechnology;
  guide: Guide;
  guide_accommodation: GuideAccommodation;
  guide_audience: GuideAudience;
  guide_author: GuideAuthor;
  guide_disorder: GuideDisorder;
  guide_disorder_category: GuideDisorderCategory;
  guide_guide_type: GuideGuideType;
  guide_intervention: GuideIntervention;
  guide_reference: GuideReference;
  guide_technology: GuideTechnology;
  guide_type: GuideType;
  intervention: Intervention;
  intervention_research_evidence: InterventionResearchEvidence;
  language_source: LanguageSource;
  lisa_domain: LisaDomain;
  lisa_domain_locale: LisaDomainLocale;
  lisa_guide: LisaGuide;
  lisa_guide_locale: LisaGuideLocale;
  lisa_subdomain: LisaSubdomain;
  lisa_subdomain_guide: LisaSubdomainGuide;
  lisa_subdomain_guide_locale: LisaSubdomainGuideLocale;
  lisa_subdomain_locale: LisaSubdomainLocale;
  locale: Locale;
  neutral_construct: NeutralConstruct;
  question: Question;
  question_response_type: QuestionResponseType;
  questionnaire: Questionnaire;
  questionnaire_assessment_reference: QuestionnaireAssessmentReference;
  questionnaire_author: QuestionnaireAuthor;
  questionnaire_disorder: QuestionnaireDisorder;
  questionnaire_disorder_category: QuestionnaireDisorderCategory;
  questionnaire_language_not_mhdb: QuestionnaireLanguageNotMhdb;
  questionnaire_respondent: QuestionnaireRespondent;
  questionnaire_sign_symptom: QuestionnaireSignSymptom;
  questionnaire_subject: QuestionnaireSubject;
  research_evidence: ResearchEvidence;
  resource_people_audience: ResourcePeopleAudience;
  response_type: ResponseType;
  sign_symptom: SignSymptom;
  sign_symptom_accommodation: SignSymptomAccommodation;
  sign_symptom_example: SignSymptomExample;
  sign_symptom_intervention: SignSymptomIntervention;
  sign_symptom_neutral_construct: SignSymptomNeutralConstruct;
  sign_symptom_technology: SignSymptomTechnology;
  sign_symptom_with_example: SignSymptomwithExample;
  state_domain_behaviour: StateDomainBehaviour;
  task: Task;
  technology: Technology;
  technology_research_evidence: TechnologyResearchEvidence;
};
