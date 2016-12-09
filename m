From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:35:20 +0000
Subject: [cip-dev] [PATCH 4.4-cip 08/23] mm/filemap:
 generic_file_read_iter(): check for zero reads unconditionally
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243720.1860.164.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Nicolai Stange <nicstange@gmail.com>

commit e7080a439a6f507abbc860847c33efc39b5c1c6d upstream.

If
 - generic_file_read_iter() gets called with a zero read length,
 - the read offset is at a page boundary,
 - IOCB_DIRECT is not set
-  and the page in question hasn't made it into the page cache yet,
then do_generic_file_read() will trigger a readahead with a req_size hint
of zero.

Since roundup_pow_of_two(0) is undefined, UBSAN reports

  UBSAN: Undefined behaviour in include/linux/log2.h:63:13
  shift exponent 64 is too large for 64-bit type 'long unsigned int'
  CPU: 3 PID: 1017 Comm: sa1 Tainted: G L 4.5.0-next-20160318+ #14
  [...]
  Call Trace:
   [...]
   [<ffffffff813ef61a>] ondemand_readahead+0x3aa/0x3d0
   [<ffffffff813ef61a>] ? ondemand_readahead+0x3aa/0x3d0
   [<ffffffff813c73bd>] ? find_get_entry+0x2d/0x210
   [<ffffffff813ef9c3>] page_cache_sync_readahead+0x63/0xa0
   [<ffffffff813cc04d>] do_generic_file_read+0x80d/0xf90
   [<ffffffff813cc955>] generic_file_read_iter+0x185/0x420
   [...]
   [<ffffffff81510b06>] __vfs_read+0x256/0x3d0
   [...]

when get_init_ra_size() gets called from ondemand_readahead().

The net effect is that the initial readahead size is arch dependent for
requested read lengths of zero: for example, since

  1UL << (sizeof(unsigned long) * 8)

evaluates to 1 on x86 while its result is 0 on ARMv7, the initial readahead
size becomes 4 on the former and 0 on the latter.

What's more, whether or not the file access timestamp is updated for zero
length reads is decided differently for the two cases of IOCB_DIRECT
being set or cleared: in the first case, generic_file_read_iter()
explicitly skips updating that timestamp while in the latter case, it is
always updated through the call to do_generic_file_read().

According to POSIX, zero length reads "do not modify the last data access
timestamp" and thus, the IOCB_DIRECT behaviour is POSIXly correct.

Let generic_file_read_iter() unconditionally check the requested read
length at its entry and return immediately with success if it is zero.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 mm/filemap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c588d1222b2a..521bd370339c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1766,15 +1766,16 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t retval = 0;
 	loff_t *ppos = &iocb->ki_pos;
 	loff_t pos = *ppos;
+	size_t count = iov_iter_count(iter);
+
+	if (!count)
+		goto out; /* skip atime */
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		struct address_space *mapping = file->f_mapping;
 		struct inode *inode = mapping->host;
-		size_t count = iov_iter_count(iter);
 		loff_t size;
 
-		if (!count)
-			goto out; /* skip atime */
 		size = i_size_read(inode);
 		retval = filemap_write_and_wait_range(mapping, pos,
 					pos + count - 1);
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
