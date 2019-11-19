From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 19 Nov 2019 08:46:26 -0800
Subject: [cip-dev] [PATCH 4.19 000/422] 4.19.85-stable review
In-Reply-To: <20191119122909.GC1913916@kroah.com>
References: <20191119051400.261610025@linuxfoundation.org>
 <TYAPR01MB22854E4F20C28F3A10DA65E3B74C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191119122909.GC1913916@kroah.com>
Message-ID: <20191119164626.GA5739@roeck-us.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, Nov 19, 2019 at 01:29:09PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 19, 2019 at 08:54:25AM +0000, Chris Paterson wrote:
> > Hello Greg, all,
> > 
> > > From: stable-owner at vger.kernel.org <stable-owner@vger.kernel.org> On
> > > Behalf Of Greg Kroah-Hartman
> > > Sent: 19 November 2019 05:13
> > > 
> > > This is the start of the stable review cycle for the 4.19.85 release.
> > > There are 422 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > 
> > I'm seeing some build issues with module compilation with this release (1b1960cc Linux 4.19.85-rc1), I also saw them with the previous two versions of Linux 4.19.85-rc1 (cd21ecdb and 1fd0ac64).
> > 
> > Full log available on GitLab [0]. Build conf [1].
> > [0] https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/354591285
> > [1] https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/354591285/artifacts/file/output/4.19.85-rc1_1b1960cc7/x86/siemens_iot2000.config/config/.config
> > 
> > Main error below:
> > 
> > 3907   CC [M]  drivers/net/ethernet/mellanox/mlx4/main.o
> > 3908   LD [M]  fs/ntfs/ntfs.o
> > 3909   CC [M]  drivers/net/ethernet/intel/i40evf/i40e_txrx.o
> > 3910   CC [M]  drivers/usb/musb/musb_core.o
> > 3911   CC [M]  drivers/net/ethernet/nvidia/forcedeth.o
> > 3912   CC [M]  fs/udf/balloc.o
> > 3913   CC [M]  drivers/net/ethernet/intel/fm10k/fm10k_debugfs.o
> > 3914   CC [M]  fs/udf/dir.o
> > 3915   CC [M]  drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.o
> > 3916   CC [M]  drivers/net/ethernet/intel/i40e/i40e_ptp.o
> > 3917 drivers/net/ethernet/mellanox/mlx4/main.c: In function 'mlx4_init_one':
> > 3918 drivers/net/ethernet/mellanox/mlx4/main.c:3985:2: error: implicit declaration of function 'devlink_reload_enable'; did you mean 'devlink_region_create'? [-Werror=implicit-function-declaration]
> > 3919   devlink_reload_enable(devlink);
> > 3920   ^~~~~~~~~~~~~~~~~~~~~
> > 3921   devlink_region_create
> > 3922   CC [M]  drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.o
> > 3923 drivers/net/ethernet/mellanox/mlx4/main.c: In function 'mlx4_remove_one':
> > 3924 drivers/net/ethernet/mellanox/mlx4/main.c:4097:2: error: implicit declaration of function 'devlink_reload_disable'; did you mean 'devlink_region_destroy'? [-Werror=implicit-function-declaration]
> > 3925   devlink_reload_disable(devlink);
> > 3926   ^~~~~~~~~~~~~~~~~~~~~~
> > 3927   devlink_region_destroy
> > 3928   CC [M]  drivers/net/ethernet/packetengines/hamachi.o
> > 3929   CC [M]  fs/udf/file.o
> > 3930   LD [M]  drivers/net/ethernet/intel/fm10k/fm10k.o
> > 
> > I haven't tried to trace the issue further yet, sorry.
> 
> Any chance you can bisect this?  I don't see any obvious reason why this
> error should be happening, and it isn't showing up here :(
> 
I see the problem as well, with powerpc:defconfig.

Underlying issue is that devlink_reload_disable() is only declared in the
include file if CONFIG_NET_DEVLINK is enabled. There is no dummy otherwise.
The dummy declarations which still exist in 4.19 were removed with commit
f6b19b354d50c ("net: devlink: select NET_DEVLINK from drivers") in the
upstream kernel.

Guenter
