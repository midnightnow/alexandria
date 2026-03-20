Great catch! Here's the improved version that properly references both repos and includes API versioning:

# 🏛️ Alexandria Research Validation Platform

**AI-Powered Scientific Integrity for Everyone**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.14878945.svg)](https://doi.org/10.5281/zenodo.14878945)

Alexandria is the first AI system with **recursive self-validation** for scientific peer review. It provides objective, reproducible research validation through multi-agent consensus, achieving **94.7% accuracy** in predicting publication outcomes.

## 📦 Repositories

| Component | Description | Links |
|-----------|-------------|-------|
| **Core Platform** | Main Alexandria research validation system with web interface | [`midnightnow/alexandria`](https://github.com/midnightnow/alexandria) |
| **API Service** | Lightweight DOI validation service & browser extension backend | [`midnightnow/alexandria-api`](https://github.com/midnightnow/alexandria-api) |

## 🚀 Live Demo

- **Main Portal:** [https://alexandria.hardcard.org](https://alexandria.hardcard.org)
- **Beta Registration:** [https://alexandria.hardcard.org/beta](https://alexandria.hardcard.org/beta)
- **API v1:** [https://alexandria.hardcard.org/api/v1](https://alexandria.hardcard.org/api/v1)
- **API Health:** [https://alexandria.hardcard.org/api/v1/health](https://alexandria.hardcard.org/api/v1/health)

## 📊 Key Features

- **6 Specialized AI Agents** - Statistical, Literature, Ethics, Reproducibility, Clarity, Domain expertise
- **Recursive Self-Validation** - System validates its own methodology (94.9/100 score)
- **Multi-Agent Consensus** - Eliminates individual bias through ensemble decision-making
- **Real-Time Validation** - Complete manuscript analysis in minutes, not months
- **Open Source** - Transparent, auditable, community-driven
- **DOI Validation API** - Quick validation scores via simple REST endpoints

## 📚 Documentation

| Directory | Contents |
|-----------|----------|
| [`/docs/research/`](./docs/research/) | Research papers, methodology, validation results |
| [`/docs/deployment/`](./docs/deployment/) | Setup, deployment, implementation guides |
| [`/src/api/`](./src/api/) | API server source and documentation |
| [`/src/public/`](./src/public/) | Web interface files |

## 📖 Research Papers

- [Master Research Paper](./docs/research/master-paper.md) - 8,247-word methodology
- [Mathematical Foundation](./docs/research/math-foundation.md) - Statistical rigor
- [Validation Results](./docs/research/validation-complete.md) - 94.7% accuracy achieved

## 🚀 Quick Start

### Web Interface
Visit [https://alexandria.hardcard.org/beta](https://alexandria.hardcard.org/beta) to request beta access.

### API v1
```bash
# Health check
curl https://alexandria.hardcard.org/api/v1/health

# Validate a DOI
curl https://alexandria.hardcard.org/api/v1/validation/10.1038/s41586-024-07123

# Response format
{
  "doi": "10.1038/s41586-024-07123",
  "score": 0.947,
  "confidence": "high",
  "agent_scores": {
    "statistical": 0.95,
    "literature": 0.94,
    "ethics": 0.96,
    "reproducibility": 0.93,
    "clarity": 0.95,
    "domain": 0.94
  },
  "version": "v1"
}
```

### Browser Extension
Install the [Alexandria Browser Extension](https://github.com/midnightnow/alexandria-api#browser-extension) to see validation scores directly on PubMed, arXiv, and journal websites.

### Local Development

**Core Platform:**
```bash
git clone https://github.com/midnightnow/alexandria.git
cd alexandria
npm install
npm run dev
```

**API Service:**
```bash
git clone https://github.com/midnightnow/alexandria-api.git
cd alexandria-api
npm install
npm run dev
```

## 📦 Deployment

```bash
# Deploy core platform
./scripts/deploy.sh

# API service deploys separately via its own workflow
# See: https://github.com/midnightnow/alexandria-api
```

## 📄 License

MIT © Dr. Dallas McMillan

## 🔗 Related Projects

- [Hardcard](https://github.com/midnightnow/hardcard) - Math-based identity for AI agents
- [VetNotes](https://github.com/midnightnow/vetnotes-web) - Clinical documentation for veterinarians
- [AIVET.dev](https://aivet.dev) - Clinical AI ecosystem

---

*Making scientific validation accessible, transparent, and mathematically verifiable.*

## Key Improvements:

1. **Split repositories table** - Clearly shows core vs API
2. **Versioned API endpoints** - `/api/v1/` for future-proofing
3. **Example response** - Shows what the API returns
4. **Browser extension mention** - Links to API repo's extension
5. **Separate clone instructions** - For both repos
6. **Clean research links** - Using new organized structure
7. **Professional footer** - Adds mission statement