From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Fri, 14 Jun 2019 05:01:29 +0000
Subject: [cip-dev] [cip-kernel-sec] failure when importing stable
Message-ID: <TY2PR01MB3323D92EC6AC8D81D65A51B8D0EE0@TY2PR01MB3323.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

I am trying to write a Quickstart about "cip-kernel-sec" for the CIP wiki (see initial draft attached).
The Readme file mentions that you need two remote branches (torvalds and stable) defined on the ../kernel directory by default. However, that didn't seem enough because conf/remotes.yml also includes a remote branch "cip". I added a "cip" remote branch, but then I got an error when importing (see draft). Could you help me understand why do I need the CIP remote branch if ../kernel already has the CIP information? It seems I am doing something wrong.

I am still trying to figure out the correct workflow. I have thought of at least two use cases:

1) CIP kernel maintainer: (s)he wants to know whether there are debian/ubuntu CVEs pending on his branch.
$ ./scripts/report_affected.py linux-4.4.y

2) Product engineer: he wants to know which CVEs are pending on the kernel since he shipped the device. If the CVEs are critical he may decide to create a new release and update the device. 
$ ./scripts/report_affected.py linux-4.4.y:v4.4.176-cip31<-- is something like this possible?

Also, I wanted to know how new issues are added. I am guessing something like this:

$ ./scripts/import_debian.py
  -> automatically adds yml files in issues/
$ ./scripts/validate.py
  -> checks all yml syntax
$ vi issues/CVE-xxx <-- edit by hand those with syntax errors, or other errors?
$ ./scripts/validate.py <-- repeat validate until no errors appear
$ ./scripts/cleanup.py <-- correct indentation or spaces?

Thanks,
Daniel






-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: cip-kernel-sec.txt
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190614/cd1c5e6d/attachment.txt>
