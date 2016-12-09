From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:35:46 +0000
Subject: [cip-dev] [PATCH 4.4-cip 10/23] drm/radeon: don't include
 RADEON_HPD_NONE in HPD IRQ enable bitsets
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243746.1860.166.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Nicolai Stange <nicstange@gmail.com>

commit b2c0cbd657173f024138d6421774007690ceeffd upstream.

The values of all but the RADEON_HPD_NONE members of the radeon_hpd_id
enum transform 1:1 into bit positions within the 'enabled' bitset as
assembled by evergreen_hpd_init():

  enabled |= 1 << radeon_connector->hpd.hpd;

However, if ->hpd.hpd happens to equal RADEON_HPD_NONE == 0xff, UBSAN
reports

  UBSAN: Undefined behaviour in drivers/gpu/drm/radeon/evergreen.c:1867:16
  shift exponent 255 is too large for 32-bit type 'int'
  [...]
  Call Trace:
   [<ffffffff818c4d35>] dump_stack+0xbc/0x117
   [<ffffffff818c4c79>] ? _atomic_dec_and_lock+0x169/0x169
   [<ffffffff819411bb>] ubsan_epilogue+0xd/0x4e
   [<ffffffff81941cbc>] __ubsan_handle_shift_out_of_bounds+0x1fb/0x254
   [<ffffffffa0ba7f2e>] ? atom_execute_table+0x3e/0x50 [radeon]
   [<ffffffff81941ac1>] ? __ubsan_handle_load_invalid_value+0x158/0x158
   [<ffffffffa0b87700>] ? radeon_get_pll_use_mask+0x130/0x130 [radeon]
   [<ffffffff81219930>] ? wake_up_klogd_work_func+0x60/0x60
   [<ffffffff8121a35e>] ? vprintk_default+0x3e/0x60
   [<ffffffffa0c603c4>] evergreen_hpd_init+0x274/0x2d0 [radeon]
   [<ffffffffa0c603c4>] ? evergreen_hpd_init+0x274/0x2d0 [radeon]
   [<ffffffffa0bd196e>] radeon_modeset_init+0x8ce/0x18d0 [radeon]
   [<ffffffffa0b71d86>] radeon_driver_load_kms+0x186/0x350 [radeon]
   [<ffffffffa03b6b16>] drm_dev_register+0xc6/0x100 [drm]
   [<ffffffffa03bc8c4>] drm_get_pci_dev+0xe4/0x490 [drm]
   [<ffffffff814b83f0>] ? kfree+0x220/0x370
   [<ffffffffa0b687c2>] radeon_pci_probe+0x112/0x140 [radeon]
   [...]
  =====================================================================
  radeon 0000:01:00.0: No connectors reported connected with modes

At least on x86, there should be no user-visible impact as there

  1 << 0xff == 1 << (0xff & 31) == 1 << 31

holds and 31 > RADEON_MAX_HPD_PINS. Thus, this patch is a cosmetic one.

All of the above applies analogously to evergreen_hpd_fini(),
r100_hpd_init(), r100_hpd_fini(), r600_hpd_init(), r600_hpd_fini(),
rs600_hpd_init() and rs600_hpd_fini()

Silence UBSAN by checking ->hpd.hpd for RADEON_HPD_NONE before oring it
into the 'enabled' bitset in the *_init()- or the 'disabled' bitset in
the *_fini()-functions respectively.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/gpu/drm/radeon/evergreen.c | 6 ++++--
 drivers/gpu/drm/radeon/r100.c      | 6 ++++--
 drivers/gpu/drm/radeon/r600.c      | 6 ++++--
 drivers/gpu/drm/radeon/rs600.c     | 6 ++++--
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 32491355a1d4..6792df8ed01a 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -1864,7 +1864,8 @@ void evergreen_hpd_init(struct radeon_device *rdev)
 			break;
 		}
 		radeon_hpd_set_polarity(rdev, radeon_connector->hpd.hpd);
-		enabled |= 1 << radeon_connector->hpd.hpd;
+		if (radeon_connector->hpd.hpd != RADEON_HPD_NONE)
+			enabled |= 1 << radeon_connector->hpd.hpd;
 	}
 	radeon_irq_kms_enable_hpd(rdev, enabled);
 }
@@ -1907,7 +1908,8 @@ void evergreen_hpd_fini(struct radeon_device *rdev)
 		default:
 			break;
 		}
-		disabled |= 1 << radeon_connector->hpd.hpd;
+		if (radeon_connector->hpd.hpd != RADEON_HPD_NONE)
+			disabled |= 1 << radeon_connector->hpd.hpd;
 	}
 	radeon_irq_kms_disable_hpd(rdev, disabled);
 }
diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 9e7e2bf03b81..9c5f47099216 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -592,7 +592,8 @@ void r100_hpd_init(struct radeon_device *rdev)
 
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 		struct radeon_connector *radeon_connector = to_radeon_connector(connector);
-		enable |= 1 << radeon_connector->hpd.hpd;
+		if (radeon_connector->hpd.hpd != RADEON_HPD_NONE)
+			enable |= 1 << radeon_connector->hpd.hpd;
 		radeon_hpd_set_polarity(rdev, radeon_connector->hpd.hpd);
 	}
 	radeon_irq_kms_enable_hpd(rdev, enable);
@@ -614,7 +615,8 @@ void r100_hpd_fini(struct radeon_device *rdev)
 
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 		struct radeon_connector *radeon_connector = to_radeon_connector(connector);
-		disable |= 1 << radeon_connector->hpd.hpd;
+		if (radeon_connector->hpd.hpd != RADEON_HPD_NONE)
+			disable |= 1 << radeon_connector->hpd.hpd;
 	}
 	radeon_irq_kms_disable_hpd(rdev, disable);
 }
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index cc2fdf0be37a..116373c24d08 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -1002,7 +1002,8 @@ void r600_hpd_init(struct radeon_device *rdev)
 				break;
 			}
 		}
-		enable |= 1 << radeon_connector->hpd.hpd;
+		if (radeon_connector->hpd.hpd != RADEON_HPD_NONE)
+			enable |= 1 << radeon_connector->hpd.hpd;
 		radeon_hpd_set_polarity(rdev, radeon_connector->hpd.hpd);
 	}
 	radeon_irq_kms_enable_hpd(rdev, enable);
@@ -1055,7 +1056,8 @@ void r600_hpd_fini(struct radeon_device *rdev)
 				break;
 			}
 		}
-		disable |= 1 << radeon_connector->hpd.hpd;
+		if (radeon_connector->hpd.hpd != RADEON_HPD_NONE)
+			disable |= 1 << radeon_connector->hpd.hpd;
 	}
 	radeon_irq_kms_disable_hpd(rdev, disable);
 }
diff --git a/drivers/gpu/drm/radeon/rs600.c b/drivers/gpu/drm/radeon/rs600.c
index 6244f4e44e9a..4b35213fe028 100644
--- a/drivers/gpu/drm/radeon/rs600.c
+++ b/drivers/gpu/drm/radeon/rs600.c
@@ -413,7 +413,8 @@ void rs600_hpd_init(struct radeon_device *rdev)
 		default:
 			break;
 		}
-		enable |= 1 << radeon_connector->hpd.hpd;
+		if (radeon_connector->hpd.hpd != RADEON_HPD_NONE)
+			enable |= 1 << radeon_connector->hpd.hpd;
 		radeon_hpd_set_polarity(rdev, radeon_connector->hpd.hpd);
 	}
 	radeon_irq_kms_enable_hpd(rdev, enable);
@@ -439,7 +440,8 @@ void rs600_hpd_fini(struct radeon_device *rdev)
 		default:
 			break;
 		}
-		disable |= 1 << radeon_connector->hpd.hpd;
+		if (radeon_connector->hpd.hpd != RADEON_HPD_NONE)
+			disable |= 1 << radeon_connector->hpd.hpd;
 	}
 	radeon_irq_kms_disable_hpd(rdev, disable);
 }
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
