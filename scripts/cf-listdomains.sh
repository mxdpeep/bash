#!/bin/bash

CF_API="https://api.cloudflare.com/client/v4"
PAGE=1
PER_PAGE=50

cd "$(dirname "$0")"
export PATH=$PATH:/snap/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH=$PATH:$HOME/go/bin:$HOME/.cargo/bin:$HOME/bin:$HOME/scripts

. ./_includes.sh
if [ -f "./_cf_key.sh" ]; then . ./_cf_key.sh; fi
if [ -z "$CF_TOKEN" ]; then fail "Missing CF_TOKEN token value!"; fi;

# parameters
if [ $# -eq 0 ]; then dom="all"; fi
if [ $# -eq 1 ]; then dom=$1; fi
if [ $# -gt 1 ]; then info "\nUsage: \t$0 [<domain.tld>]\n\n"; exit; fi

# list all zones (max. 50)
r=$(curl -s -X GET "${CF_API}/zones?status=active&page=${PAGE}&per_page=${PER_PAGE}&match=all" \
     -H "Authorization: Bearer ${CF_TOKEN}" -H "Content-Type: application/json")
names=$(echo $r|jq ".result[].name"|sed 's/"//g')
count=$(echo $names|sed 's/ /\n/g'|wc -l)

j=0
for i in $names
do
  ((j++))
  if [ "$dom" != "all" ]; then if [ "$dom" != "$i" ]; then continue; fi; fi

  # get current zone
  r=$(curl -s -X GET "${CF_API}/zones?name=${i}&status=active&page=1&per_page=1&match=all" \
     -H "Authorization: Bearer ${CF_TOKEN}" \
     -H "Content-Type: application/json")
  id=$(echo $r|jq ".result[].id"|sed 's/"//g')
  name=$(echo $r|jq ".result[].name"|sed 's/"//g')
  owner=$(echo $r|jq ".result[].owner.email"|sed 's/"//g')
  echo -en "$j/$count "
  infogreen "${name}"
  echo "id: ${id} account: ${owner}"
done

exit 0
