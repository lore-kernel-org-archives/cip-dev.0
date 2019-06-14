From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 14 Jun 2019 14:00:45 +0100
Subject: [cip-dev] [cip-kernel-sec] failure when importing stable
In-Reply-To: <TY2PR01MB3323D92EC6AC8D81D65A51B8D0EE0@TY2PR01MB3323.jpnprd01.prod.outlook.com>
References: <TY2PR01MB3323D92EC6AC8D81D65A51B8D0EE0@TY2PR01MB3323.jpnprd01.prod.outlook.com>
Message-ID: <1560517245.21054.27.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2019-06-14 at 05:01 +0000, daniel.sangorrin at toshiba.co.jp
wrote:
> Hello Ben,
> 
> I am trying to write a Quickstart about "cip-kernel-sec" for the CIP
> wiki (see initial draft attached).
> The Readme file mentions that you need two remote branches (torvalds
> and stable) defined on the ../kernel directory by default. However,
> that didn't seem enough because conf/remotes.yml also includes a
> remote branch "cip".

So the README should refer to that file rather than repeating a list of
remotes.

> I added a "cip" remote branch, but then I got an error when importing
> (see draft). Could you help me understand why do I need the CIP
> remote branch if ../kernel already has the CIP information? It seems
> I am doing something wrong.

import_stable.py doesn't update the "torvalds" remote, and neither did
you, so you don't have all the expected tags.

I suppose that import_stable.py should do that.

> I am still trying to figure out the correct workflow. I have thought
> of at least two use cases:
> 
> 1) CIP kernel maintainer: (s)he wants to know whether there are
> debian/ubuntu CVEs pending on his branch.
> $ ./scripts/report_affected.py linux-4.4.y
> 
> 2) Product engineer: he wants to know which CVEs are pending on the
> kernel since he shipped the device. If the CVEs are critical he may
> decide to create a new release and update the device.?
> $ ./scripts/report_affected.py linux-4.4.y:v4.4.176-cip31<-- is
> something like this possible?

Not yet but it would probably not be hard to do.

> Also, I wanted to know how new issues are added. I am guessing
> something like this:
> 
> $ ./scripts/import_debian.py
> ? -> automatically adds yml files in issues/
> $ ./scripts/validate.py
> ? -> checks all yml syntax

You don't need to run validate.py immediately after an import, unless
you suspect a bug in the importer.  It's only important after hand-
editing.

> $ vi issues/CVE-xxx <-- edit by hand those with syntax errors, or
> other errors?

You would edit by hand if you see that some imported information is
incorrect or there is missing information.

> $ ./scripts/validate.py <-- repeat validate until no errors appear
> $ ./scripts/cleanup.py <-- correct indentation or spaces?

YAML allows the same thing to be written in different ways, e.g.
bracketed vs bulleted lists.  The purpose of cleanup.py is to make the
syntax and ordering of items consistent with the importers, to reduce
"noise" in diffs.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
