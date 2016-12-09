From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:34:57 +0000
Subject: [cip-dev] [PATCH 4.4-cip 06/23] perf/core: Fix Undefined behaviour
 in rb_alloc()
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243697.1860.162.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Peter Zijlstra <peterz@infradead.org>

commit 8184059e93c200757f5c0805dae0f14e880eab5d upstream.

Sasha reported:

 [ 3494.030114] UBSAN: Undefined behaviour in kernel/events/ring_buffer.c:685:22
 [ 3494.030647] shift exponent -1 is negative

Andrey spotted that this is because:

  It happens if nr_pages = 0:
     rb->page_order = ilog2(nr_pages);

Fix it by making both assignments conditional on nr_pages; since
otherwise they should both be 0 anyway, and will be because of the
kzalloc() used to allocate the structure.

Reported-by: Sasha Levin <sasha.levin@oracle.com>
Reported-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20160129141751.GA407 at worktop
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 kernel/events/ring_buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 014b69528194..7beb02f40cb4 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -754,8 +754,10 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 
 	rb->user_page = all_buf;
 	rb->data_pages[0] = all_buf + PAGE_SIZE;
-	rb->page_order = ilog2(nr_pages);
-	rb->nr_pages = !!nr_pages;
+	if (nr_pages) {
+		rb->nr_pages = 1;
+		rb->page_order = ilog2(nr_pages);
+	}
 
 	ring_buffer_init(rb, watermark, flags);
 
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
