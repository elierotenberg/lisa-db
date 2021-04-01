# Contributing

## Local setup

1. Download and install your favorite code editor (the project comes pre-configured for [VSCode](https://code.visualstudio.com/))
2. Download and install [Node JS](https://nodejs.org/en/download/)
3. Create a Github account
4. Fork the repository under e.g. `git@github.com:YOUR_USERNAME/lisa-db.git`, clone it locally, and create a working branch:
```
git clone git@github.com:YOUR_USERNAME/lisa-db.git
git checkout -b @content/add-my-custom-guide
```
5. Install dependencies
```
npm install
```
6. Start the development server
```
npm run dev
```

When done editing, push your branch to your fork repository and submit a [Pull Request](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/proposing-changes-to-your-work-with-pull-requests).

## Adding or editing content

### File structure

Each content (domain, guide, institution, person) is represented by a `.mdx` file, with two parts:
1. A header with metadata in [YAML](https://en.wikipedia.org/wiki/YAML),
2. A body with actual content in [Markdown](https://en.wikipedia.org/wiki/Markdown) (actually, a variant of Markdown called [MDX](https://mdxjs.com/))

A content file is therefore an MDX file wit the following structure:

```mdx
----
metadata in yml
---

content in markdown
```

The exact headers depends on the kind of content, but an example for a guide is:

```yml
kind: guide
guide_id: cmi-school-kit-adhd
locale: en
slug: cmi-school-kit-adhd
name: School Success Kit for Kids with ADHD
abstract: Tools and strategies to help manage time, stay focused, and handle homework
authors:
  - person_id: rae-jacobson
curators:
  - person_id: anirudh-krishnakumar
domains:
  - domain_id: attention
  - domain_id: hyperactivity
audiences:
  - teachers
  - families
source:
  institution_id: cmi
  locale: en
  name: School Success Kit for Kids with ADHD
  href: https://childmind.org/article/school-success-kit-for-kids-with-adhd/
```

Each content has a unique id (here `guide_id`) that is used to consolidate different versions of the same content in different languages (locales). The id must be unique per content, and preferably in kebab case (see below).

The `slug` property is used in the URL path and should be in so called "kebab case" (e.g. this-is-a-correct-slug, thisIsNotAcorrectSlug and this_is_not_a_correct_slug).

The `locale` property identifies the language (locale): `en` for English, `fr` for French, and `pt` for Portuguese.

Other metadata property depend on the kind of content.

### Directory structure

Each content file should be placed in a subfolder under the appropriate content kind, preferably in a common folder for different locale versions. File naming is purely conventional but should ideally also be in kebab case.

### Adding or editing content

To create a new content, you may used existing content as templates, taking care to update metadata accordingly.

When new content is added, or its metadata is updated, the content index must be rebuilt using:
```
npm run parse-contents
```

This will update `src/content/db/index.ts` accordingly. Content is also (in part) validated by this step.

Editing the body doesn't require reindexing and changes are automatically updated.