From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Wed, 09 Jan 2019 17:13:25 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 4
 commits: The Ubuntu CVE tracker migrated from bzr to git. Use new url in
 import_ubuntu.py script.
Message-ID: <5c362bb5cee91_492e3f9edd0f73f8648724@sidekiq-asap-05-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
a3a90572 by Christophe Kassabji at 2018-08-02T15:28:47Z
The Ubuntu CVE tracker migrated from bzr to git. Use new url in import_ubuntu.py script.
- - - - -
4ffab6a9 by Ben Hutchings at 2019-01-09T17:02:42Z
Merge branch &#39;master&#39; of https://gitlab.com/ckassabji/cip-kernel-sec

- - - - -
4062b400 by Ben Hutchings at 2019-01-09T17:06:37Z
Clean up remnants of Bazaar-NG

* scripts/import_ubuntu.py: Delete local Bazaar-NG repository if present
* README.md: Drop it from requirements

- - - - -
cf3ca110 by Ben Hutchings at 2019-01-09T17:11:56Z
Import data from Ubuntu

But override the fixed-by field for CVE-2016-10723, as the commit
they recorded is not a complete fix.

- - - - -


30 changed files:

- README.md
- issues/CVE-2013-7445.yml
- issues/CVE-2016-10208.yml
- issues/CVE-2016-10723.yml
- issues/CVE-2016-7913.yml
- issues/CVE-2016-8660.yml
- issues/CVE-2016-9588.yml
- issues/CVE-2017-11472.yml
- issues/CVE-2017-11473.yml
- issues/CVE-2017-12154.yml
- issues/CVE-2017-12193.yml
- issues/CVE-2017-13693.yml
- issues/CVE-2017-13694.yml
- issues/CVE-2017-13695.yml
- issues/CVE-2017-14991.yml
- issues/CVE-2017-15265.yml
- issues/CVE-2017-15299.yml
- issues/CVE-2017-15649.yml
- issues/CVE-2017-16526.yml
- issues/CVE-2017-16527.yml
- issues/CVE-2017-16529.yml
- issues/CVE-2017-16531.yml
- issues/CVE-2017-16532.yml
- issues/CVE-2017-16533.yml
- issues/CVE-2017-16535.yml
- issues/CVE-2017-16536.yml
- issues/CVE-2017-16537.yml
- issues/CVE-2017-16538.yml
- issues/CVE-2017-16643.yml
- issues/CVE-2017-16644.yml


The diff was not included because it is too large.


View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/45b595b96c7783ede7e743212368da373a20b6c8...cf3ca11062c4d9dc1cef3848f106f2da0d08f347

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/45b595b96c7783ede7e743212368da373a20b6c8...cf3ca11062c4d9dc1cef3848f106f2da0d08f347
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190109/ff999590/attachment.html>
