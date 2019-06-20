From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 20 Jun 2019 17:27:57 +0100
Subject: [cip-dev] [RFC] Script to find used sources in the kernel
Message-ID: <1561048077.21054.46.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I've been promising for some time to provide a way to identify which
changes on Linux stable branches are relevant to CIP members, and
conversely which are irrelevant and don't need to be reviewed.

This is a proof-of-concept of the major part of that, which is to
identify which source files are used based on the submitted
configurations.  Once this is working to everyone's satisfaction, it
should be fairly easy to automate the remaining parts, which are (1)
merge the source lists for each branch (4.4, 4.19) and (2) check a set
of patches or commits against a list.

I implemented:

* A script to select the appropriate value of CROSS_COMPILE for a given
  configuration (cross-compile-prefix).
* A script to call the assembler or compiler and collect dependency
  information from the preprocessor into a single file
  (get_used_sources_wrapper).
* A script that builds a kernel from a given configuration file with
  get_used_sources_wrapper?wrapped around the asssembler and compilers.
  This also filters out references to missing files (like firmware)
  from the configuration file.

I tied these together with a Makefile rule that generates a source list
for each of the submitted configurations.  I was then able to generate
source lists for each of them (although it took quite a few hours).

You can find the scripts and lists on the "benhutchings/get-used-
sources" branch of
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git

There are a couple of open questions, on which I would like to hear
other's opinions:

* Should the source lists be added to the repository or not?  If they
  are added, then they should not be changed by the standard "all" and
  "clean" targets.
  I tend to think that they should be added, because they take a long
  time to generate and require cross-compilers etc. to be installed.

* If the answer to the above is "yes", should the source lists be
  generated (a) by members, and sent along with the config files, or
  (b) by the kernel maintainers?  Option (a) makes a bit more work for
  members, but option (b) might result in missing build tools due to
  the config filtering mentioned above.

Please feel free to comment on anything else.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
