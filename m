From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:35:32 +0000
Subject: [cip-dev] [PATCH 4.4-cip 09/23] perf/x86/amd: Set the size of event
 map array to PERF_COUNT_HW_MAX
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243732.1860.165.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Adam Borowski <kilobyte@angband.pl>

commit 0a25556f84d5f79e68e9502bb1f32a43377ab2bf upstream.

The entry for PERF_COUNT_HW_REF_CPU_CYCLES is not used on AMD, but is
referenced by filter_events() which expects undefined events to have a
value of 0.

Found via KASAN:

  UBSAN: Undefined behaviour in arch/x86/events/amd/core.c:132:30
  index 9 is out of range for type 'u64 [9]'
  UBSAN: Undefined behaviour in arch/x86/events/amd/core.c:132:9
  load of address ffffffff81c021c8 with insufficient space for an object of type 'const u64'

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/1461749731-30979-1-git-send-email-kilobyte at angband.pl
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 4.4: adjust filename]

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 arch/x86/kernel/cpu/perf_event_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/perf_event_amd.c b/arch/x86/kernel/cpu/perf_event_amd.c
index 1cee5d2d7ece..e671f3c2397e 100644
--- a/arch/x86/kernel/cpu/perf_event_amd.c
+++ b/arch/x86/kernel/cpu/perf_event_amd.c
@@ -115,7 +115,7 @@ static __initconst const u64 amd_hw_cache_event_ids
 /*
  * AMD Performance Monitor K7 and later.
  */
-static const u64 amd_perfmon_event_map[] =
+static const u64 amd_perfmon_event_map[PERF_COUNT_HW_MAX] =
 {
   [PERF_COUNT_HW_CPU_CYCLES]			= 0x0076,
   [PERF_COUNT_HW_INSTRUCTIONS]			= 0x00c0,
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
