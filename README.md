# AI-Powered Text-to-SQL Analytics Platform

An AI-powered analytics platform that allows users to ask business questions in natural language and receive data-driven answers by automatically generating, validating, and executing SQL queries.

## Project Overview

Business users often need data from databases but may not know SQL.

This project aims to build an AI Data Analyst that can understand natural-language questions such as:

> "What were our top 10 products by revenue last quarter?"

and convert them into safe, executable SQL queries against an enterprise ecommerce database.

The platform will:

1. Understand the user's question
2. Retrieve relevant database schema and business metadata
3. Generate SQL using an LLM
4. Validate the generated SQL
5. Prevent unsafe database operations
6. Execute approved read-only queries
7. Return results with explanations and visualizations
8. Maintain query/conversation history

## Architecture

```text
User
  │
  ▼
React Frontend
  │
  ▼
FastAPI API
  │
  ▼
LangGraph Agent
  │
  ├── Schema & Metadata Retrieval
  │       │
  │       ▼
  │    ChromaDB
  │
  ├── SQL Generation
  │       │
  │       ▼
  │    OpenAI
  │
  ├── SQL Validation
  │
  ├── SQL Optimization
  │
  └── SQL Execution
          │
          ▼
      PostgreSQL
          │
          ▼
      Results
          │
          ▼
   Explanation / Charts