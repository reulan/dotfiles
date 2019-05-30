# =========================================
# Kubernetes aliases
# =========================================
alias kc=kubectl
alias kcd='kubectl describe'
alias kcon='kubectl config use-context'
alias kc3='kubectl config current-context'
alias kcg='kubectl get'

# =========================================
# Kubernetes CLI Utility (kutil)
# =========================================
function kl() {
     kubectl logs $* | jq -R --raw-output '. as $raw | try (fromjson | .timestamp.seconds |= todateiso8601 | "\(.timestamp.seconds) - \(.filename) - \(.severity) - \(.message)") catch $raw'
 }

function eskl() {
     kubectl logs $* | jq -R --raw-output '. as $raw | try (fromjson | .timestamp.seconds |= todateiso8601 | "\(.timestamp.seconds) - \(.type) - \(.statusCode) - \(.message)") catch $raw'
     kubectl logs $* | jq -R --raw-output '. as $raw | try (fromjson | "\(.res) -  \(.message)") catch $raw'
 }

