From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:41:19 +0000
Subject: [cip-dev] [PATCH 4.4-cip 23/23] mlx4: remove unused fields
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481244079.1860.182.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: David Decotigny <decot@googlers.com>

commit 5038056e6bd45788235e97e3bcfc43f96c52ca84 upstream.

This also can address following UBSAN warnings:
[   36.640343] ================================================================================
[   36.648772] UBSAN: Undefined behaviour in drivers/net/ethernet/mellanox/mlx4/fw.c:857:26
[   36.656853] shift exponent 64 is too large for 32-bit type 'int'
[   36.663348] ================================================================================
[   36.671783] ================================================================================
[   36.680213] UBSAN: Undefined behaviour in drivers/net/ethernet/mellanox/mlx4/fw.c:861:27
[   36.688297] shift exponent 35 is too large for 32-bit type 'int'
[   36.694702] ================================================================================

Tested:
  reboot with UBSAN, no warning.

Signed-off-by: David Decotigny <decot@googlers.com>
Acked-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/net/ethernet/mellanox/mlx4/fw.c | 4 ----
 drivers/net/ethernet/mellanox/mlx4/fw.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
index 90db94e83fde..ebff502db8ff 100644
--- a/drivers/net/ethernet/mellanox/mlx4/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
@@ -760,12 +760,8 @@ int mlx4_QUERY_DEV_CAP(struct mlx4_dev *dev, struct mlx4_dev_cap *dev_cap)
 	dev_cap->max_eqs = 1 << (field & 0xf);
 	MLX4_GET(field, outbox, QUERY_DEV_CAP_RSVD_MTT_OFFSET);
 	dev_cap->reserved_mtts = 1 << (field >> 4);
-	MLX4_GET(field, outbox, QUERY_DEV_CAP_MAX_MRW_SZ_OFFSET);
-	dev_cap->max_mrw_sz = 1 << field;
 	MLX4_GET(field, outbox, QUERY_DEV_CAP_RSVD_MRW_OFFSET);
 	dev_cap->reserved_mrws = 1 << (field & 0xf);
-	MLX4_GET(field, outbox, QUERY_DEV_CAP_MAX_MTT_SEG_OFFSET);
-	dev_cap->max_mtt_seg = 1 << (field & 0x3f);
 	MLX4_GET(size, outbox, QUERY_DEV_CAP_NUM_SYS_EQ_OFFSET);
 	dev_cap->num_sys_eqs = size & 0xfff;
 	MLX4_GET(field, outbox, QUERY_DEV_CAP_MAX_REQ_QP_OFFSET);
diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.h b/drivers/net/ethernet/mellanox/mlx4/fw.h
index 08de5555c2f4..711af4e506f3 100644
--- a/drivers/net/ethernet/mellanox/mlx4/fw.h
+++ b/drivers/net/ethernet/mellanox/mlx4/fw.h
@@ -78,9 +78,7 @@ struct mlx4_dev_cap {
 	int max_eqs;
 	int num_sys_eqs;
 	int reserved_mtts;
-	int max_mrw_sz;
 	int reserved_mrws;
-	int max_mtt_seg;
 	int max_requester_per_qp;
 	int max_responder_per_qp;
 	int max_rdma_global;
-- 
2.10.2


-- 
Ben Hutchings
Software Developer, Codethink Ltd.
