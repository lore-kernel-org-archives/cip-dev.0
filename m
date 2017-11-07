From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 07 Nov 2017 17:41:50 +0000
Subject: [cip-dev] Automating Open Source License Compliance - Kate Stewart
In-Reply-To: <1510076438.2465.31.camel@codethink.co.uk>
References: <1510076438.2465.31.camel@codethink.co.uk>
Message-ID: <1510076510.2465.32.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

## Automating Open Source License Compliance - Kate Stewart

[Description](https://osseu17.sched.com/event/BxI3/)

A product distribution may need to include copyright statements,
licence statements, disclaimers.

Why is this a problem???Open source projects are changing quickly,
bringing in more copyrights and licenses.??Sometimes a project's
license doesn't actually apply to every source file.

Different sponsoring organisations and distributions have different
policies for which licenses they accept and how they're recorded.
Language specific package repositories also have their own standards
for recording licenses.

Wish lists for automation:

* Developers want a simple concise way to mark source files with
? license, checked at build time
* Open Source Offices want accurate license summary for third party
? software, and their own.??She referred to "Trusted Upstream
? Processes" but didn't expand on that.

SPDX (Software Package Data eXchange) provides standard ways to
identify licenses, to tag source files and to summarise this
information in a manifest.??Common OSS licenses are assigned short
names; custom licenses are also supported.

SPDX license identifiers supported by Debian (DEP-5), and other
distributions and organisations considering adopting them.??U-Boot
uses them, Linux is starting to use them, Eclipse Package Manager(?)
will start soon.

"Open Government Partnership" created a best practices template
that includes use of SPDX license identifiers.

An SPDX v2.1 document has metadata for itself, each package covered,
each source file included in packages, and any "snippets" (parts of
a source file) with a different license.

Various tooling is needed and available.??Open source tools include
FOSSology, ScanCode, SPDXTools; more are listed at
<https://wiki.debian.org/CopyrightReviewTools>.??Proprietary tools
are available from Wind River, Black Duck, others.

How accurate are the scanning tools???All are based partly on
heuristics.??She recomends testing them against a known set of source
files.

She mentioned some other types of tools, but I wasn't clear on what
they do.

The OpenChain project documents the process of license compliance(?),
which is useful for a supply chain.

Missing pieces:

* Trusted SPDX importers (for reviewed documents?)
* CI/CD build tool integration (check for tags at build time?)
* Curated real world examples
* End-to-end case studies using SPDX documents

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
