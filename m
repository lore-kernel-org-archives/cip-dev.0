From: nobuhiro.iwamatsu@miraclelinux.com (Nobuhiro Iwamatsu)
Date: Mon, 17 Dec 2018 16:00:38 +0900
Subject: [cip-dev] Linux 4.4.166-cip29
In-Reply-To: <TYAPR01MB2160268A30AF06F2E0CE6C24D7BC0@TYAPR01MB2160.jpnprd01.prod.outlook.com>
References: <CAGDrK-YxePqVJLS+m3DnGZ1pQaa6aS33vhoA5JkKa+Py9NEKNA@mail.gmail.com>
	<TYAPR01MB21604A7303995531CBAE2DE6D7BC0@TYAPR01MB2160.jpnprd01.prod.outlook.com>
	<TYAPR01MB2160268A30AF06F2E0CE6C24D7BC0@TYAPR01MB2160.jpnprd01.prod.outlook.com>
Message-ID: <CAGDrK-Z5yffHQS+2SA+jF6GQXucXQoMFbifDBASPJpYb-qD=eA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

Oh, sorry.
I pushed only tags. I have updated the linux-4.4.y-cip branch now.

Best regards,
  Nobuhiro

2018?12?17?(?) 15:28 ???? / KOGUCHI?TAKUO <takuo.koguchi.sw@hitachi.com>:
>
> Iwamatsu-san,
>
> Before tagging, please update localversion-cip file.
>
> Yoroshiku,
>
> Takuo Koguchi
>
>
> > -----Original Message-----
> > From: ???? / KOGUCHI?TAKUO
> > Sent: Monday, December 17, 2018 1:05 PM
> > To: 'Nobuhiro Iwamatsu' <nobuhiro.iwamatsu@miraclelinux.com>;
> > cip-dev at lists.cip-project.org
> > Subject: RE: [!][cip-dev] Linux 4.4.166-cip29
> >
> > Iwamatsu-san,
> >
> > Thank you very much for the release.  I'd like you to put a tag like v4.4.166-cip29 as Ben
> > usually did.
> >
> > Best Regards,
> >
> > Takuo Koguchi
> > Hitachi, Ltd.
> >
> >
> > > -----Original Message-----
> > > From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> On
> > > Behalf Of Nobuhiro Iwamatsu
> > > Sent: Saturday, December 15, 2018 4:10 AM
> > > To: cip-dev at lists.cip-project.org
> > > Subject: [!][cip-dev] Linux 4.4.166-cip29
> > >
> > > Hi, all.
> > >
> > > I've released Linux version Linux 4.4.166-cip29.
> > >
> > >
> > https://clicktime.symantec.com/a/1/UEQdWtsbt5Qk7txECDKJfx95gRWdpJLaLCNkOozvIQU=?d=zqF75B
> > >
> > _Es8pNfh-1i8IkBPJZpY_3fHMbY4Q1cAMTg59g6fatSuVAZvuF2hT1aYT3vo8h4_tiTOHhszY-p6KRxpK1TfFaj0
> > >
> > xK6P_OMbod8C5TFM1bLjozBx2UPmae1Fs8LeWs2Nv4ds9rlbwKtThA--ozlHSRID6TKxs0IABJiRrGHW9jPqHoHJ
> > >
> > x4x5319Eo489d333Bb4LVKejOSRp1MRY8mxTb40k7fy2F9ePBOPxzd__F-iORW5x_N28RX_YjSwv-Z1Fe3TNRaXw
> > >
> > U618DG1b53DqRfvnHC39cb0duMO8qQAow8xeXm7yPOZf4yozhjNSQGN3g-gVaWrUWvWcUpoh2ZyjimCbqMrCFHxn
> > >
> > UfllLYfe6skvSDxXQoANegiudysI4Z3ca5gRbnFZsAuyGi_QDRDl4kUx6KLsj0&u=https%3A%2F%2Fgit.kerne
> > >
> > l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fcip%2Flinux-cip.git%2Ftag%2F%3Fh%3Dv4.4.166-c
> > > ip29
> > >
> > > The fix from Linux 4.4.154-cip 28 is as follows.
> > >
> > > - Update dts of r8a77xx
> > >   ARM: dts: r8a7743: Add PMU device node
> > >   ARM: dts: r8a7745: Add PMU device node
> > >   ARM: dts: r8a77(43|9[013]): Add missing OPP properties for CPUs
> > > - Update to 4.4.166
> > > - Change dts file name of socfpga DE0 sockit board
> > >   ARM: dts: socfpga: Rename socfpga_cyclone5_de0_{sockit, nano_soc}
> > >
> > > Best regards,
> > >   Nobuhiro
> > > _______________________________________________
> > > cip-dev mailing list
> > > cip-dev at lists.cip-project.org
> > >
> > https://clicktime.symantec.com/a/1/L8OIV7-lhI4Fx2rNwdYkOZhmpOczOWYjIkKZRamVsPk=?d=zqF75B
> > >
> > _Es8pNfh-1i8IkBPJZpY_3fHMbY4Q1cAMTg59g6fatSuVAZvuF2hT1aYT3vo8h4_tiTOHhszY-p6KRxpK1TfFaj0
> > >
> > xK6P_OMbod8C5TFM1bLjozBx2UPmae1Fs8LeWs2Nv4ds9rlbwKtThA--ozlHSRID6TKxs0IABJiRrGHW9jPqHoHJ
> > >
> > x4x5319Eo489d333Bb4LVKejOSRp1MRY8mxTb40k7fy2F9ePBOPxzd__F-iORW5x_N28RX_YjSwv-Z1Fe3TNRaXw
> > >
> > U618DG1b53DqRfvnHC39cb0duMO8qQAow8xeXm7yPOZf4yozhjNSQGN3g-gVaWrUWvWcUpoh2ZyjimCbqMrCFHxn
> > >
> > UfllLYfe6skvSDxXQoANegiudysI4Z3ca5gRbnFZsAuyGi_QDRDl4kUx6KLsj0&u=https%3A%2F%2Flists.cip
> > > -project.org%2Fmailman%2Flistinfo%2Fcip-dev
