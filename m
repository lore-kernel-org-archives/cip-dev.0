From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 26 Apr 2017 15:53:39 +0100
Subject: [cip-dev] CVE tracking for the kernel
Message-ID: <1493218419.10415.120.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This week I have done more work on scripts to track CVEs across mainline
and stable branches.  I now have scripts to incrementally import data
from Debian and Ubuntu's trackers (descriptions, comments, commit
hashes) and to combine this with git commit logs to work out which
issues affect each branch.  I've had to make some manual fixes to the
data, but mostly this Just Works - out of 164 issues imported, I
corrected errors in 3 and added missing information to 32.

I thought about using a database and web forms for this, but that would
complicate hosting.  For now, the issues are stored in the git
repository in YAML format, one issue per file.  There's validation code
that checks the format quite strictly, so it should be possible to
convert to a database schema at some later date.

The scripts and issue data are now at:
https://gitlab.com/cip-project/cip-kernel-sec

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
