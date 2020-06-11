FROM alpine:3.10.3

LABEL "com.github.actions.name"="GA-AddRemoveLabel"
LABEL "com.github.actions.description"="Manage labels on pull requests"
LABEL "com.github.actions.icon"="aperture"
LABEL "com.github.actions.color"="blue"

LABEL version="0.0.1"
LABEL repository="https://github.com/justia/ga-add-remove-label"
LABEL homepage="https://github.com/justia/ga-add-remove-label"

RUN apk add --no-cache bash curl jq && rm -rf /var/lib/apt/lists/*

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
