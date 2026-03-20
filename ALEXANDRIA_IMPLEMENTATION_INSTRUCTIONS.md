# Alexandria Implementation Instructions: From Installation to Research Validation

**Complete Technical Guide for Human and LLM Users**

---

## 🚀 Quick Start (5 Minutes to First Validation)

### Option 1: Docker Deployment (Recommended)
```bash
# Clone the repository
git clone https://github.com/hardcard/alexandria-peer-review
cd alexandria-peer-review

# Quick deployment with Docker
chmod +x quick-deploy.sh
./quick-deploy.sh

# Alexandria will be running at http://localhost:8080
# Dashboard: http://localhost:8080/dashboard
# API: http://localhost:8080/api/v1
```

### Option 2: Manual Installation
```bash
# Install dependencies
npm install

# Start the service
npm start

# Or with development mode
npm run dev
```

### Option 3: Cloud Deployment (AWS/GCP/Azure)
```bash
# Deploy to cloud with one command
docker build -t alexandria-peer-review .
docker run -d -p 80:3000 --env-file .env.production alexandria-peer-review

# Scale with Docker Compose
docker-compose up -d --scale alexandria-service=3
```

---

## 📋 Prerequisites and System Requirements

### Minimum Requirements
- **CPU:** 2 cores, 2.4 GHz
- **RAM:** 8 GB
- **Storage:** 20 GB free space
- **Network:** Stable internet connection
- **OS:** Linux, macOS, or Windows with WSL2

### Recommended for Production
- **CPU:** 8+ cores, 3.0+ GHz
- **RAM:** 32 GB
- **Storage:** 100 GB SSD
- **Network:** High-speed connection (100+ Mbps)
- **Load Balancer:** For multiple instances

### Software Dependencies
```json
{
  "node": ">=16.0.0",
  "npm": ">=8.0.0",
  "docker": ">=20.0.0",
  "python": ">=3.8" 
}
```

---

## ⚙️ Configuration Guide

### Environment Variables
Create `.env` file:
```bash
# Core Configuration
NODE_ENV=production
PORT=3000
API_VERSION=v1

# External API Keys (Required for full functionality)
SCITE_API_KEY=your_scite_api_key_here
CROSSREF_EMAIL=your.email@institution.edu
PUBMED_API_KEY=your_pubmed_api_key

# Database Configuration
REDIS_URL=redis://localhost:6379
MONGODB_URL=mongodb://localhost:27017/alexandria

# Service Configuration
MAX_CONCURRENT_VALIDATIONS=10
RATE_LIMIT=100
CACHE_TTL=3600000
ENABLE_DASHBOARD=true
ENABLE_WEBHOOKS=true

# Security
JWT_SECRET=your_secure_jwt_secret_here
ADMIN_PASSWORD=secure_admin_password
```

### API Keys Setup
```bash
# Get scite.ai API key (recommended for citation analysis)
# 1. Visit https://scite.ai/api
# 2. Sign up for research account
# 3. Generate API key
export SCITE_API_KEY="your_key_here"

# PubMed API (for biomedical research)
# 1. Register at https://www.ncbi.nlm.nih.gov/account/
# 2. Generate API key
export PUBMED_API_KEY="your_key_here"

# CrossRef (free, requires email)
export CROSSREF_EMAIL="researcher@institution.edu"
```

---

## 🔧 Core Implementation

### 1. Basic Manuscript Validation

```javascript
// Import the Alexandria service
const { AlexandriaPeerReviewService } = require('./alexandria-peer-review-service.js');

// Initialize the service
const alexandria = new AlexandriaPeerReviewService({
  enable_external_apis: true,
  validation_mode: 'comprehensive',
  max_concurrent_validations: 5
});

// Validate a manuscript
async function validateResearch() {
  const manuscript = {
    title: "Your Research Title",
    authors: ["Dr. Jane Smith", "Prof. John Doe"],
    abstract: "Research abstract...",
    domain: "biomedical_sciences",
    citations: [
      {
        title: "Previous Research Citation",
        doi: "10.1000/182",
        authors: ["Previous Author"]
      }
    ],
    key_claims: [
      "Our method improves accuracy by 15%",
      "The approach is statistically significant (p<0.05)"
    ]
  };
  
  try {
    const result = await alexandria.validateManuscript(manuscript, {
      mode: 'comprehensive',
      domain: 'biomedical_sciences'
    }, {
      ip: '127.0.0.1',
      user_agent: 'Research Validator'
    });
    
    console.log('📊 Validation Results:');
    console.log(`Score: ${result.overall_validation_score.toFixed(1)}/100`);
    console.log(`Publication Ready: ${result.publication_readiness ? 'YES' : 'NO'}`);
    console.log(`Processing Time: ${result.service_metadata.processing_time}ms`);
    
    return result;
  } catch (error) {
    console.error('Validation failed:', error);
    return null;
  }
}

// Run validation
validateResearch();
```

### 2. Real-Time Fact Checking

```python
#!/usr/bin/env python3
"""
Alexandria Fact Checking Implementation
"""
import requests
import json

class AlexandriaFactChecker:
    def __init__(self, api_base_url="http://localhost:8080/api/v1"):
        self.api_base_url = api_base_url
        self.session = requests.Session()
    
    def check_claim(self, claim, domain="general", evidence_level="standard"):
        """
        Fact-check a scientific claim
        """
        payload = {
            "claim": claim,
            "domain": domain,
            "evidence_level": evidence_level,
            "sources": ["scite", "crossref", "pubmed", "semantic_scholar"]
        }
        
        try:
            response = self.session.post(
                f"{self.api_base_url}/fact-check",
                json=payload,
                timeout=30
            )
            
            if response.status_code == 200:
                return response.json()
            else:
                return {"error": f"API error: {response.status_code}"}
                
        except requests.RequestException as e:
            return {"error": f"Request failed: {str(e)}"}
    
    def validate_citation(self, doi):
        """
        Validate a DOI citation
        """
        payload = {"doi": doi}
        
        response = self.session.post(
            f"{self.api_base_url}/validate-citation",
            json=payload
        )
        
        return response.json()
    
    def assess_source_credibility(self, journal, authors=None):
        """
        Assess credibility of a source
        """
        payload = {
            "journal": journal,
            "authors": authors or []
        }
        
        response = self.session.post(
            f"{self.api_base_url}/assess-source",
            json=payload
        )
        
        return response.json()

# Example usage
if __name__ == "__main__":
    fact_checker = AlexandriaFactChecker()
    
    # Check a scientific claim
    result = fact_checker.check_claim(
        claim="Hydroxychloroquine is effective for COVID-19 treatment",
        domain="medical_research",
        evidence_level="comprehensive"
    )
    
    print(f"Claim Validation Score: {result.get('validation_score', 'N/A')}/100")
    print(f"Evidence Quality: {result.get('evidence_quality', 'Unknown')}")
    print(f"Consensus: {result.get('consensus', 'Unclear')}")
```

### 3. Batch Processing for Large Datasets

```bash
#!/bin/bash
# Batch validation script for multiple manuscripts

ALEXANDRIA_API="http://localhost:8080/api/v1"
INPUT_DIR="manuscripts"
OUTPUT_DIR="validation_results"

mkdir -p "$OUTPUT_DIR"

echo "🚀 Starting batch validation..."

for manuscript in "$INPUT_DIR"/*.json; do
    echo "📄 Validating $(basename "$manuscript")..."
    
    curl -X POST "$ALEXANDRIA_API/validate" \
        -H "Content-Type: application/json" \
        -d @"$manuscript" \
        -o "$OUTPUT_DIR/$(basename "$manuscript" .json)_validation.json" \
        --silent
    
    echo "✅ Complete: $(basename "$manuscript")"
    sleep 2  # Rate limiting
done

echo "🎉 Batch validation complete! Results in $OUTPUT_DIR"
```

---

## 🔗 API Integration Examples

### REST API Endpoints

```bash
# Health Check
curl http://localhost:8080/api/v1/health

# Single Manuscript Validation
curl -X POST http://localhost:8080/api/v1/validate \
     -H "Content-Type: application/json" \
     -d '{
       "manuscript": {
         "title": "Research Title",
         "abstract": "Abstract text...",
         "domain": "computer_science"
       },
       "options": {
         "mode": "comprehensive"
       }
     }'

# Fact Check a Claim
curl -X POST http://localhost:8080/api/v1/fact-check \
     -H "Content-Type: application/json" \
     -d '{
       "claim": "AI systems can achieve 95% accuracy in medical diagnosis",
       "domain": "medical_ai",
       "evidence_sources": ["pubmed", "scite"]
     }'

# Batch Validation
curl -X POST http://localhost:8080/api/v1/validate/batch \
     -H "Content-Type: application/json" \
     -d '{
       "manuscripts": [
         {"title": "Paper 1", "abstract": "..."},
         {"title": "Paper 2", "abstract": "..."}
       ],
       "options": {"mode": "standard"}
     }'

# Get System Metrics
curl http://localhost:8080/api/v1/metrics

# Trigger Self-Validation
curl -X POST http://localhost:8080/api/v1/self-validate
```

### WebSocket Real-Time Updates

```javascript
// Real-time validation updates
const WebSocket = require('ws');

const ws = new WebSocket('ws://localhost:8080/ws/validation');

ws.on('open', function open() {
  console.log('🔗 Connected to Alexandria WebSocket');
  
  // Subscribe to validation updates
  ws.send(JSON.stringify({
    action: 'subscribe',
    type: 'validation_updates'
  }));
});

ws.on('message', function message(data) {
  const update = JSON.parse(data);
  
  switch(update.type) {
    case 'validation_started':
      console.log(`📄 Started validating: ${update.manuscript_title}`);
      break;
    case 'validation_progress':
      console.log(`⏳ Progress: ${update.progress}% - ${update.current_phase}`);
      break;
    case 'validation_complete':
      console.log(`✅ Complete: Score ${update.score}/100`);
      break;
    case 'validation_error':
      console.error(`❌ Error: ${update.error_message}`);
      break;
  }
});
```

---

## 🎯 Advanced Configuration

### Custom Domain Specialization

```javascript
// Add custom domain expert
const customDomainConfig = {
  domain: "quantum_computing",
  validation_criteria: {
    quantum_algorithms: {
      weight: 0.3,
      required_elements: ["quantum_gates", "circuit_depth", "error_rates"]
    },
    theoretical_foundation: {
      weight: 0.25,
      required_elements: ["complexity_analysis", "quantum_advantage"]
    },
    experimental_validation: {
      weight: 0.25,
      required_elements: ["hardware_specs", "noise_characterization"]
    },
    reproducibility: {
      weight: 0.2,
      required_elements: ["circuit_code", "parameter_settings"]
    }
  },
  expert_agents: [
    "quantum_algorithm_specialist",
    "quantum_hardware_expert", 
    "quantum_complexity_theorist"
  ]
};

alexandria.addCustomDomain(customDomainConfig);
```

### Integration with Institutional Systems

```python
# Integration with university research management system
import alexandria_sdk

class UniversityAlexandriaIntegration:
    def __init__(self, university_api_key, alexandria_endpoint):
        self.alexandria = alexandria_sdk.Client(alexandria_endpoint)
        self.university_key = university_api_key
    
    def validate_thesis_submission(self, thesis_data):
        """Validate PhD thesis before committee review"""
        
        # Extract manuscript data from thesis
        manuscript = self.extract_manuscript_data(thesis_data)
        
        # Run Alexandria validation
        validation_result = self.alexandria.validate_manuscript(
            manuscript,
            mode='comprehensive',
            domain=thesis_data.get('department_domain')
        )
        
        # Generate institutional report
        report = self.generate_institutional_report(
            validation_result, 
            thesis_data
        )
        
        # Log to university system
        self.log_validation_to_university_system(
            thesis_data['student_id'], 
            validation_result,
            report
        )
        
        return {
            'validation_score': validation_result.overall_score,
            'publication_ready': validation_result.publication_readiness,
            'committee_recommendation': self.generate_committee_recommendation(validation_result),
            'improvement_plan': validation_result.recommendations
        }
    
    def validate_grant_proposal(self, proposal_data):
        """Validate research proposal for funding"""
        return self.alexandria.validate_manuscript(
            proposal_data,
            mode='standard',
            focus_areas=['methodology', 'innovation', 'feasibility']
        )
```

### Custom Validation Workflows

```yaml
# workflow_config.yml - Custom validation pipeline
validation_workflows:
  medical_research:
    phases:
      - ethical_review:
          agents: ["ethical_guardian", "medical_ethics_specialist"]
          weight: 0.15
          required_score: 85
      - clinical_methodology:
          agents: ["clinical_trials_expert", "statistical_inquisitor"]
          weight: 0.35
          required_score: 90
      - safety_assessment:
          agents: ["patient_safety_expert", "adverse_events_analyzer"]
          weight: 0.25
          required_score: 95
      - reproducibility_check:
          agents: ["methodological_purist", "data_transparency_validator"]
          weight: 0.25
          required_score: 80
    
  computer_science:
    phases:
      - algorithmic_correctness:
          agents: ["algorithm_validator", "complexity_analyzer"]
          weight: 0.30
      - experimental_design:
          agents: ["experimental_design_expert", "benchmark_validator"]
          weight: 0.30
      - code_quality:
          agents: ["code_reviewer", "reproducibility_checker"]
          weight: 0.25
      - theoretical_soundness:
          agents: ["theoretical_computer_scientist", "proof_validator"]
          weight: 0.15
```

---

## 📊 Monitoring and Analytics

### System Health Dashboard

```javascript
// Create custom monitoring dashboard
const express = require('express');
const app = express();

app.get('/admin/dashboard', async (req, res) => {
  const health = await alexandria.getServiceHealth();
  const metrics = await alexandria.getSystemMetrics();
  
  const dashboardData = {
    system_status: health.status,
    uptime: health.uptime_human,
    total_validations: metrics.total_validations,
    success_rate: metrics.accuracy_rate,
    average_score: metrics.average_validation_score,
    active_sessions: health.system.active_validations,
    queue_length: health.system.queue_length,
    recent_validations: await alexandria.getRecentValidations(10)
  };
  
  res.render('dashboard', dashboardData);
});
```

### Performance Monitoring

```python
# Performance monitoring and alerting
import time
import logging
from alexandria_sdk import Client

class AlexandriaMonitor:
    def __init__(self, alexandria_client):
        self.client = alexandria_client
        self.logger = logging.getLogger(__name__)
    
    def monitor_performance(self, interval_seconds=60):
        """Monitor system performance continuously"""
        while True:
            try:
                start_time = time.time()
                
                # Health check
                health = self.client.get_health()
                
                # Performance test
                test_manuscript = self.get_test_manuscript()
                validation_result = self.client.validate(test_manuscript)
                
                response_time = time.time() - start_time
                
                # Log metrics
                self.logger.info(f"Health: {health['status']}")
                self.logger.info(f"Response time: {response_time:.2f}s")
                self.logger.info(f"Validation score: {validation_result.get('overall_score', 'N/A')}")
                
                # Alert on issues
                if response_time > 10:
                    self.send_alert(f"Slow response time: {response_time:.2f}s")
                
                if health['status'] != 'healthy':
                    self.send_alert(f"System unhealthy: {health}")
                
                time.sleep(interval_seconds)
                
            except Exception as e:
                self.logger.error(f"Monitoring error: {e}")
                self.send_alert(f"Monitoring failed: {e}")
                time.sleep(interval_seconds)
    
    def send_alert(self, message):
        """Send alert to administrators"""
        # Implement your alerting system (email, Slack, etc.)
        print(f"🚨 ALERT: {message}")
```

---

## 🛡️ Security and Production Hardening

### Security Configuration

```bash
# Security hardening script
#!/bin/bash

echo "🔒 Hardening Alexandria production deployment..."

# Update system packages
sudo apt update && sudo apt upgrade -y

# Install security tools
sudo apt install -y fail2ban ufw

# Configure firewall
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable

# Configure fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Set up SSL certificates (Let's Encrypt)
sudo apt install -y certbot nginx
sudo certbot --nginx -d your-alexandria-domain.com

# Secure Docker daemon
sudo usermod -aG docker $USER
sudo systemctl enable docker

# Set secure permissions
chmod 600 .env
chmod 600 config/*.json

echo "✅ Security hardening complete!"
```

### Backup and Recovery

```bash
#!/bin/bash
# Automated backup script for Alexandria

BACKUP_DIR="/backups/alexandria"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="alexandria_backup_$DATE"

echo "📦 Starting Alexandria backup..."

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Backup database
docker exec alexandria-mongo mongodump --out "/tmp/mongo_backup_$DATE"
docker cp "alexandria-mongo:/tmp/mongo_backup_$DATE" "$BACKUP_DIR/"

# Backup Redis data
docker exec alexandria-redis redis-cli BGSAVE
docker cp alexandria-redis:/data/dump.rdb "$BACKUP_DIR/redis_$DATE.rdb"

# Backup configuration files
tar -czf "$BACKUP_DIR/config_$DATE.tar.gz" .env config/ nginx.conf

# Backup validation cache and reports
tar -czf "$BACKUP_DIR/data_$DATE.tar.gz" cache/ reports/ logs/

# Clean up old backups (keep last 30 days)
find "$BACKUP_DIR" -name "alexandria_backup_*" -mtime +30 -delete

echo "✅ Backup complete: $BACKUP_NAME"

# Upload to cloud storage (optional)
# aws s3 cp "$BACKUP_DIR/$BACKUP_NAME.tar.gz" s3://your-backup-bucket/
```

---

## 🧪 Testing and Quality Assurance

### Automated Testing Suite

```javascript
// test/alexandria.test.js
const { AlexandriaPeerReviewService } = require('../alexandria-peer-review-service');
const request = require('supertest');

describe('Alexandria Peer Review Service', () => {
  let alexandria;
  
  beforeAll(async () => {
    alexandria = new AlexandriaPeerReviewService({
      validation_mode: 'fast',
      enable_external_apis: false // Use mock APIs for testing
    });
    await alexandria.initialize();
  });
  
  test('validates high-quality manuscript correctly', async () => {
    const goodManuscript = {
      title: 'Well-Designed Study on Important Topic',
      abstract: 'Comprehensive abstract with clear methodology...',
      domain: 'biomedical_sciences',
      citations: [
        { title: 'Relevant Citation', doi: '10.1000/123' }
      ]
    };
    
    const result = await alexandria.validateManuscript(goodManuscript);
    
    expect(result.overall_validation_score).toBeGreaterThan(80);
    expect(result.publication_readiness).toBe(true);
    expect(result.validation_complete).toBe(true);
  });
  
  test('identifies problematic research correctly', async () => {
    const problematicManuscript = {
      title: 'Questionable Study',
      abstract: 'Vague methodology, unclear results...',
      domain: 'psychology',
      citations: [] // No citations - red flag
    };
    
    const result = await alexandria.validateManuscript(problematicManuscript);
    
    expect(result.overall_validation_score).toBeLessThan(60);
    expect(result.publication_readiness).toBe(false);
    expect(result.final_assessment.concerns.length).toBeGreaterThan(0);
  });
  
  test('handles API errors gracefully', async () => {
    // Test with malformed input
    const invalidManuscript = {
      // Missing required fields
      domain: 'invalid_domain'
    };
    
    const result = await alexandria.validateManuscript(invalidManuscript);
    
    expect(result.status).toBe('error');
    expect(result.error_message).toBeDefined();
  });
});

// Run tests
// npm test
```

### Load Testing

```python
# load_test.py - Performance testing script
import asyncio
import aiohttp
import time
import statistics

async def validate_manuscript(session, manuscript_data):
    """Send validation request"""
    try:
        async with session.post(
            'http://localhost:8080/api/v1/validate',
            json=manuscript_data
        ) as response:
            return await response.json(), response.status
    except Exception as e:
        return {'error': str(e)}, 500

async def load_test(concurrent_users=10, requests_per_user=5):
    """Run load test with multiple concurrent users"""
    
    test_manuscript = {
        "manuscript": {
            "title": "Load Test Manuscript",
            "abstract": "Testing system performance under load...",
            "domain": "computer_science"
        },
        "options": {"mode": "fast"}
    }
    
    async with aiohttp.ClientSession() as session:
        tasks = []
        start_time = time.time()
        
        # Create concurrent requests
        for user in range(concurrent_users):
            for request in range(requests_per_user):
                task = validate_manuscript(session, test_manuscript)
                tasks.append(task)
        
        # Execute all requests
        results = await asyncio.gather(*tasks, return_exceptions=True)
        
        end_time = time.time()
        total_time = end_time - start_time
        
        # Analyze results
        successful_requests = [r for r in results if isinstance(r, tuple) and r[1] == 200]
        failed_requests = len(results) - len(successful_requests)
        
        if successful_requests:
            response_times = [r[0].get('processing_time', 0) for r in successful_requests]
            avg_response_time = statistics.mean(response_times)
            max_response_time = max(response_times)
            min_response_time = min(response_times)
        else:
            avg_response_time = max_response_time = min_response_time = 0
        
        # Report results
        print(f"\n🧪 LOAD TEST RESULTS")
        print(f"=" * 50)
        print(f"Concurrent Users: {concurrent_users}")
        print(f"Requests per User: {requests_per_user}")
        print(f"Total Requests: {len(results)}")
        print(f"Total Time: {total_time:.2f}s")
        print(f"Requests per Second: {len(results)/total_time:.2f}")
        print(f"Successful Requests: {len(successful_requests)}")
        print(f"Failed Requests: {failed_requests}")
        print(f"Success Rate: {(len(successful_requests)/len(results)*100):.1f}%")
        print(f"Avg Response Time: {avg_response_time:.2f}ms")
        print(f"Min Response Time: {min_response_time:.2f}ms")
        print(f"Max Response Time: {max_response_time:.2f}ms")

if __name__ == "__main__":
    asyncio.run(load_test(concurrent_users=50, requests_per_user=10))
```

---

## 🔧 Troubleshooting Guide

### Common Issues and Solutions

**Issue: API Connection Timeout**
```bash
# Check if service is running
curl http://localhost:8080/api/v1/health

# If not responding, restart service
docker restart alexandria-service

# Check logs for errors
docker logs alexandria-service -f
```

**Issue: Low Validation Scores**
```javascript
// Check if external APIs are configured
const config = await alexandria.getConfiguration();
console.log('External APIs enabled:', config.enable_external_apis);
console.log('API keys configured:', {
  scite: !!process.env.SCITE_API_KEY,
  pubmed: !!process.env.PUBMED_API_KEY
});

// Run system self-validation to verify functionality
const selfValidation = await alexandria.performSystemSelfValidation();
console.log('System validation score:', selfValidation.overall_score);
```

**Issue: Memory/Performance Problems**
```bash
# Monitor resource usage
docker stats alexandria-service

# Increase memory allocation
docker run -m 4g alexandria-peer-review

# Scale with multiple instances
docker-compose up -d --scale alexandria-service=3
```

**Issue: Database Connection Errors**
```bash
# Check database status
docker exec alexandria-mongo mongo --eval "db.adminCommand('ping')"
docker exec alexandria-redis redis-cli ping

# Restart databases if needed
docker restart alexandria-mongo alexandria-redis
```

### Debug Mode

```bash
# Enable debug logging
export NODE_ENV=development
export DEBUG=alexandria:*
export LOG_LEVEL=debug

# Start service with verbose logging
npm run dev

# Or with Docker
docker run -e DEBUG=alexandria:* -e LOG_LEVEL=debug alexandria-peer-review
```

### System Health Check Script

```bash
#!/bin/bash
# comprehensive_health_check.sh

echo "🏥 Alexandria System Health Check"
echo "================================"

# Check service status
echo "1. Service Status:"
SERVICE_STATUS=$(curl -s http://localhost:8080/api/v1/health | jq -r '.status // "unreachable"')
echo "   Alexandria Service: $SERVICE_STATUS"

# Check database connections
echo "2. Database Status:"
MONGO_STATUS=$(docker exec alexandria-mongo mongo --quiet --eval "db.adminCommand('ping').ok" 2>/dev/null || echo "0")
REDIS_STATUS=$(docker exec alexandria-redis redis-cli ping 2>/dev/null || echo "PONG")
echo "   MongoDB: $([ "$MONGO_STATUS" = "1" ] && echo "Connected" || echo "Disconnected")"
echo "   Redis: $([ "$REDIS_STATUS" = "PONG" ] && echo "Connected" || echo "Disconnected")"

# Check external API connectivity
echo "3. External APIs:"
if [ -n "$SCITE_API_KEY" ]; then
    echo "   Scite.ai: Configured"
else
    echo "   Scite.ai: Not configured"
fi

if [ -n "$PUBMED_API_KEY" ]; then
    echo "   PubMed: Configured"  
else
    echo "   PubMed: Not configured"
fi

# Performance test
echo "4. Performance Test:"
START_TIME=$(date +%s%N)
curl -s http://localhost:8080/api/v1/health > /dev/null
END_TIME=$(date +%s%N)
RESPONSE_TIME=$(( (END_TIME - START_TIME) / 1000000 ))
echo "   Response Time: ${RESPONSE_TIME}ms"

# Resource usage
echo "5. Resource Usage:"
MEMORY_USAGE=$(docker stats alexandria-service --no-stream --format "{{.MemUsage}}" | awk '{print $1}')
CPU_USAGE=$(docker stats alexandria-service --no-stream --format "{{.CPUPerc}}")
echo "   Memory: $MEMORY_USAGE"
echo "   CPU: $CPU_USAGE"

echo ""
echo "Health check complete! ✅"
```

---

## 📚 Additional Resources

### SDK Documentation
- **JavaScript/Node.js:** https://github.com/hardcard/alexandria-js-sdk
- **Python:** https://github.com/hardcard/alexandria-python-sdk  
- **R:** https://github.com/hardcard/alexandria-r-package
- **MATLAB:** https://github.com/hardcard/alexandria-matlab-toolbox

### Example Applications
- **Research Validation Dashboard:** https://github.com/hardcard/alexandria-dashboard
- **Journal Integration Plugin:** https://github.com/hardcard/alexandria-journal-plugin
- **Browser Extension:** https://github.com/hardcard/alexandria-browser-extension
- **Slack Bot:** https://github.com/hardcard/alexandria-slack-bot

### Community Resources
- **Documentation:** https://docs.alexandria.systems
- **API Reference:** https://api.alexandria.systems/docs
- **Community Forum:** https://community.alexandria.systems
- **Video Tutorials:** https://youtube.com/c/AlexandriaValidation

### Professional Services
- **Implementation Consulting:** consulting@alexandria.systems
- **Custom Domain Training:** training@alexandria.systems
- **Enterprise Support:** enterprise@alexandria.systems
- **Academic Partnerships:** partnerships@alexandria.systems

---

**🏛️ Alexandria: Democratizing Scientific Validation Through AI**

*Complete technical implementation guide - from installation to production deployment*

**Need help? Contact our support team at support@alexandria.systems** 🚀