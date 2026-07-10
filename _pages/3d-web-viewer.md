---
layout: page
permalink: /3d-web-viewer/
title: 3DWebViewer
description: Explore a collection of interactive 3D environments, point clouds, and gaussian splats rendered directly in your browser.
nav: true
nav_order: 3
---

<style>
  :root {
    --card-bg: var(--global-bg-color, #ffffff);
    --card-border: var(--global-divider-color, #e2e8f0);
    --text-main: var(--global-text-color, #0f172a);
    --text-muted: var(--global-text-muted-color, #64748b);
    --accent: var(--global-theme-color, #3b82f6);
  }
  
  .grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 32px;
    width: 100%;
    margin-top: 2rem;
  }

  .card {
    background: var(--card-bg);
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.025);
    border: 1px solid var(--card-border);
    transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
    display: flex;
    flex-direction: column;
    text-decoration: none;
    color: inherit;
    position: relative;
  }

  .card:hover {
    transform: translateY(-8px);
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.08), 0 8px 10px -6px rgba(0, 0, 0, 0.04);
    border-color: rgba(59, 130, 246, 0.3);
    text-decoration: none;
    color: inherit;
  }

  .card-image-wrapper {
    width: 100%;
    aspect-ratio: 4/3;
    overflow: hidden;
    position: relative;
    background: #f1f5f9;
  }

  .card-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.6s cubic-bezier(0.16, 1, 0.3, 1);
  }

  .card:hover .card-image {
    transform: scale(1.05);
  }

  .card-content {
    padding: 24px;
    display: flex;
    flex-direction: column;
    flex-grow: 1;
  }

  .card-badge {
    align-self: flex-start;
    background: #eff6ff;
    color: #2563eb;
    font-size: 0.75rem;
    font-weight: 600;
    padding: 4px 10px;
    border-radius: 999px;
    margin-bottom: 12px;
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  .card-title {
    font-size: 1.25rem;
    font-weight: 600;
    margin-bottom: 8px;
    line-height: 1.4;
    color: var(--text-main);
    transition: color 0.2s;
  }

  .card:hover .card-title {
    color: var(--accent);
  }

  .card-desc {
    font-size: 0.95rem;
    color: var(--text-muted);
    line-height: 1.5;
    font-weight: 300;
    margin-bottom: 20px;
  }

  .card-footer {
    margin-top: auto;
    display: flex;
    align-items: center;
    color: var(--accent);
    font-weight: 600;
    font-size: 0.9rem;
  }
  
  .card-footer svg {
    width: 16px;
    height: 16px;
    margin-left: 6px;
    transition: transform 0.3s;
  }

  .card:hover .card-footer svg {
    transform: translateX(4px);
  }
</style>

<div class="grid-container" id="models-grid">
  <!-- Cards will be dynamically injected here from models.json -->
</div>

<script>
  document.addEventListener("DOMContentLoaded", function() {
    // 3Dモデル各ページのドメイン名を設定するパラメータ
    const targetDomain = "https://www.yuya-aikw.me";
    
    // Use Jekyll's relative_url filter to get the base path correctly
    const relativeBaseUrl = "{{ '/_3rdparty/3DWebViewer' | relative_url }}";
    
    fetch(relativeBaseUrl + "/models.json")
      .then(response => response.json())
      .then(models => {
        const grid = document.getElementById("models-grid");
        
        models.forEach(model => {
          // ドメイン名 + JSON内のURL (例: /pages/...)
          const cardUrl = targetDomain + model.url;
          // Optionally handle thumbnail resolving (if they are also relative to 3DWebViewer or absolute)
          // assuming thumbnailSrc is relative to base url or root if it starts with /
          const thumbnailSrc = model.thumbnailSrc ? (model.thumbnailSrc.startsWith('/') ? model.thumbnailSrc : relativeBaseUrl + '/' + model.thumbnailSrc) : '';
          
          const card = document.createElement("a");
          card.href = cardUrl;
          card.className = "card";
          
          card.innerHTML = `
            <div class="card-image-wrapper">
              <img src="${thumbnailSrc}" alt="${model.thumbnailAlt}" class="card-image" loading="lazy">
            </div>
            <div class="card-content">
              <span class="card-badge">${model.badge}</span>
              <h2 class="card-title">${model.title}</h2>
              <p class="card-desc">${model.description}</p>
              <div class="card-footer">
                View Model 
                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
              </div>
            </div>
          `;
          
          grid.appendChild(card);
        });
      })
      .catch(error => console.error("Error loading models:", error));
  });
</script>
