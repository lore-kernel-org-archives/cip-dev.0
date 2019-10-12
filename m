From: gitlab@mg.gitlab.com (=?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?=)
Date: Sat, 12 Oct 2019 16:56:08 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 6
 commits: Import more data
Message-ID: <5da205a855d8e_502d3f989061d12861198@sidekiq-asap-05-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



SZ Lin (???) pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
7d6b6d04 by Ben Hutchings at 2019-10-06T20:00:49Z
Import more data

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
7acf4945 by Ben Hutchings at 2019-10-06T20:02:58Z
Add second commit needed to fix CVE-2019-0136 on linux-4.9.y branch

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
5c05ad84 by Ben Hutchings at 2019-10-06T20:44:07Z
Correct introduced-by commit list for CVE-2019-15917

I now think this issue goes back to the start of git history.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
1833f581 by Ben Hutchings at 2019-10-06T20:45:10Z
Fill in commit lists for CVE-2019-1125

This is finally fixed on all live branches, although the oldest
branches don&#39;t include the documentation update.

Also drop one commit from the list for linux-4.9.y that isn&#39;t really
part of the fixes.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
06c16c36 by Ben Hutchings at 2019-10-06T20:46:57Z
Fill in commit lists in various issues

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
f2989df1 by SZ Lin (???) at 2019-10-12T16:56:07Z
Merge branch &#39;bwh/update-issues&#39; into &#39;master&#39;

Update issues

See merge request cip-project/cip-kernel/cip-kernel-sec!15
- - - - -


30 changed files:

- issues/CVE-2016-10905.yml
- issues/CVE-2016-10906.yml
- issues/CVE-2017-18509.yml
- issues/CVE-2018-20856.yml
- issues/CVE-2018-20961.yml
- issues/CVE-2018-20976.yml
- issues/CVE-2019-0136.yml
- issues/CVE-2019-10126.yml
- issues/CVE-2019-10207.yml
- issues/CVE-2019-10638.yml
- issues/CVE-2019-11191.yml
- issues/CVE-2019-1125.yml
- issues/CVE-2019-11477.yml
- issues/CVE-2019-11478.yml
- issues/CVE-2019-11479.yml
- issues/CVE-2019-11486.yml
- issues/CVE-2019-11487.yml
- issues/CVE-2019-12615.yml
- issues/CVE-2019-12817.yml
- issues/CVE-2019-12984.yml
- issues/CVE-2019-13272.yml
- issues/CVE-2019-13631.yml
- issues/CVE-2019-13648.yml
- issues/CVE-2019-14283.yml
- issues/CVE-2019-14284.yml
- issues/CVE-2019-14814.yml
- issues/CVE-2019-14815.yml
- issues/CVE-2019-14816.yml
- issues/CVE-2019-14821.yml
- issues/CVE-2019-14835.yml


The diff was not included because it is too large.


View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/4dd569652193063a0fb0c30701f9962b8dc721f0...f2989df1a8bf45c10f00cfecb7dafcadd0d4ed3c

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/4dd569652193063a0fb0c30701f9962b8dc721f0...f2989df1a8bf45c10f00cfecb7dafcadd0d4ed3c
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191012/75286514/attachment.html>
