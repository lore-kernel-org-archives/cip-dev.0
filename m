From: gitlab@mg.gitlab.com (Robert Marshall)
Date: Wed, 18 Jul 2018 09:40:22 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-testing/board-at-desk-single-dev][master] 2 commits:
 More helpful final output #178
Message-ID: <5b4f0b06e1faf_1ce6c3fbbe92caa80279542@sidekiq-asap-03.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Robert Marshall pushed to branch master at cip-project / cip-testing / board-at-desk-single-dev


Commits:
db10d21f by Robert Marshall at 2018-06-13T14:08:31Z
More helpful final output #178

Tailor the output depending whether there&#39;s an authentication token
for lavauser.

- - - - -
f6ac0420 by Robert Marshall at 2018-07-18T09:40:21Z
Merge branch &#39;betterTest&#39; into &#39;master&#39;

More helpful final output #178

See merge request cip-project/cip-testing/board-at-desk-single-dev!61
- - - - -


1 changed file:

- scripts/create_test.sh


Changes:

=====================================
scripts/create_test.sh
=====================================
@@ -29,4 +29,12 @@ sed -i $OUP -e 's/TAG/'"$TAG"'/'
 sed -i $OUP -e 's/BRANCH/'"$BRANCH"'/' 
 
 
-echo now run lava-tool submit-job http://lavauser at localhost:8080/RPC2 $OUP
+# assumes that lavauser is being used (as specified in the wiki)
+AUTH=$(lava-tool auth-list | grep -c lavauser)
+if [ $AUTH -eq 1 ]
+then
+   echo now run lava-tool submit-job http://lavauser at localhost:8080/RPC2 $OUP
+else
+   echo move $OUP to /etc/lava-server/dispatcher-config/health-checks/ naming it device-type.yaml
+   echo if you want to use lava-tool you need to add an authentication token
+fi



View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/ed0c61c4022e45dcf9e089f983ed0bc557aacf63...f6ac04206848442dff3b5f18880274d9f64df61b

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/ed0c61c4022e45dcf9e089f983ed0bc557aacf63...f6ac04206848442dff3b5f18880274d9f64df61b
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180718/dcaac8ca/attachment.html>
