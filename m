From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:34:13 +0000
Subject: [cip-dev] [PATCH 4.4-cip 03/23] PM / sleep: declare __tracedata
 symbols as char[] rather than char
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243653.1860.159.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Eric Biggers <ebiggers3@gmail.com>

commit f97238373b8662a6d580e204df2e7bcbfa43e27a upstream.

Accessing more than one byte from a symbol declared simply 'char' is undefined
behavior, as reported by UBSAN:

	UBSAN: Undefined behaviour in drivers/base/power/trace.c:178:18
	load of address ffffffff8203fc78 with insufficient space
	for an object of type 'char'

Avoid this by declaring the symbols as arrays.

Signed-off-by: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/base/power/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index a311cfa4c5bd..a6975795e7f3 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -166,14 +166,14 @@ void generate_pm_trace(const void *tracedata, unsigned int user)
 }
 EXPORT_SYMBOL(generate_pm_trace);
 
-extern char __tracedata_start, __tracedata_end;
+extern char __tracedata_start[], __tracedata_end[];
 static int show_file_hash(unsigned int value)
 {
 	int match;
 	char *tracedata;
 
 	match = 0;
-	for (tracedata = &__tracedata_start ; tracedata < &__tracedata_end ;
+	for (tracedata = __tracedata_start ; tracedata < __tracedata_end ;
 			tracedata += 2 + sizeof(unsigned long)) {
 		unsigned short lineno = *(unsigned short *)tracedata;
 		const char *file = *(const char **)(tracedata + 2);
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
