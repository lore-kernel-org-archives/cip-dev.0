From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:15:03 +0000
Subject: [cip-dev] [PATCH 4.4-cip 0/5] Faster page poisoning for security
Message-ID: <1481242503.1860.139.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This is a backport of changes in 4.6 to add new config options to page
poisoning.  Page poisoning was originally intended a debug feature for
finding use-after-free bugs in the kernel, but it can also be a security
feature, mitigating the security impact of such bugs.  Unfortunately, it
normally has a significant performance cost.  The new options
(CONFIG_PAGE_POISONING_NO_SANITY and CONFIG_PAGE_POISONING_ZERO) can be
enabled to reduce the performance cost, though they also reduce the
likelihood of detecting when such a bug has been triggered.

Enable CONFIG_PAGE_POISONING plus the new options can make some such
bugs harder to exploit, at a small performance cost (you'll need to
measure it yourself).

For this and other backports, I'm looking for feedback like:
- Did I miss a follow-up fix or an earlier dependency?
- Does this cause a regression (other than as explained above)?
- Are you likely to use it?
- Are there related features you want in 4.4?

Ben.

Joonsoo Kim (3):
  mm/slab: activate debug_pagealloc in SLAB when it is actually enabled
  mm/slab: use more appropriate condition check for debug_pagealloc
  mm/slab: clean up DEBUG_PAGEALLOC processing code

Laura Abbott (2):
  mm/page_poison.c: enable PAGE_POISONING as a separate option
  mm/page_poisoning.c: allow for zero poisoning

 Documentation/kernel-parameters.txt     |  5 ++
 include/linux/mm.h                      | 23 ++++++--
 include/linux/poison.h                  |  4 ++
 kernel/power/hibernate.c                | 17 ++++++
 mm/Kconfig.debug                        | 39 ++++++++++++-
 mm/Makefile                             |  2 +-
 mm/page_alloc.c                         | 13 ++++-
 mm/page_ext.c                           | 10 +++-
 mm/{debug-pagealloc.c => page_poison.c} | 67 +++++++++++++++++-----
 mm/slab.c                               | 98 +++++++++++++++++----------------
 10 files changed, 208 insertions(+), 70 deletions(-)
 rename mm/{debug-pagealloc.c => page_poison.c} (64%)

-- 
2.10.2


-- 
Ben Hutchings
Software Developer, Codethink Ltd.
