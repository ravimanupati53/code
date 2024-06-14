---
- name: Publish Terraform module to private registry
  hosts: localhost
  gather_facts: false

  vars:
    github_repo: "https://github.com/yourusername/your-repo"
    github_token: "{{ lookup('env', 'GITHUB_TOKEN') }}"
    terraform_registry_host: "https://app.terraform.io"
    terraform_registry_token: "{{ lookup('env', 'TERRAFORM_REGISTRY_TOKEN') }}"
    module_name: "your-module-name"
    namespace: "your-namespace"
    provider: "aws"  # Adjust this to your specific provider
    vcs_repo_identifier: "yourusername/your-repo"

  tasks:
    - name: Create a new Git tag
      command: git tag v1.0.0
      args:
        chdir: "/path/to/your/terraform/module"  # Change to your module's local path
      register: git_tag

    - name: Push the new Git tag to GitHub
      command: git push origin v1.0.0
      args:
        chdir: "/path/to/your/terraform/module"  # Change to your module's local path

    - name: Create GitHub release
      uri:
        url: "https://api.github.com/repos/yourusername/your-repo/releases"
        method: POST
        headers:
          Authorization: "token {{ github_token }}"
          Content-Type: "application/json"
        body_format: json
        body: |
          {
            "tag_name": "v1.0.0",
            "target_commitish": "main",
            "name": "v1.0.0",
            "body": "Release of version v1.0.0",
            "draft": false,
            "prerelease": false
          }
      register: github_release

    - name: Register module with Terraform Private Registry
      uri:
        url: "{{ terraform_registry_host }}/api/v2/organizations/{{ namespace }}/registry-modules"
        method: POST
        headers:
          Authorization: "Bearer {{ terraform_registry_token }}"
          Content-Type: "application/vnd.api+json"
        body_format: json
        body: |
          {
            "data": {
              "type": "registry-modules",
              "attributes": {
                "vcs-repo": {
                  "identifier": "{{ vcs_repo_identifier }}",
                  "oauth-token-id": "{{ terraform_registry_token }}"
                },
                "name": "{{ module_name }}",
                "provider": "{{ provider }}"
              }
            }
          }
      register: registry_response

    - name: Debug registry response
      debug:
        var: registry_response
