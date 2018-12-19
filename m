From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 19 Dec 2018 16:08:50 +0000
Subject: [cip-dev] [ANNOUNCE] Linux kernel CVE tracker
Message-ID: <1545235730.19315.143.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

As part of my work for the Civil Infrastructure Platform, I've been
tracking security issues in the kernel and trying to ensure that the
fixes are applied to stable branches as necessary.

The "kernel-sec" repository at
<https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec> contains
information about known issues and scripts to aid in maintaining and
viewing that information.  Issues are identified by CVE ID and their
status is recorded for mainline and all live stable branches.

I import most of the information from distribution security trackers,
and from upstream commit references in stable branch commit messages. 
Manual editing is needed mostly to correct errors in these sources, or
where the commits fixing an issue in a stable branch don't correspond
exactly to the commits fixing it in mainline.

I recently added a local web application that allows browsing the
status of all branches and issues, complete with links to references
and related commits.  There is also a simple reporting script that
lists open issues for each branch.

If you're interested in security support for stable branches, please
take a look at this.

I would welcome merge requests to add to the issue data or to improve
the scripts.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
