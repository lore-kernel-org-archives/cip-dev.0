Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6387AC4332F
	for <webhook@archiver.kernel.org>; Fri, 23 Dec 2022 22:02:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.84117.1671832937875768384
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Dec 2022 14:02:18 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 2BNM1s35001966; Sat, 24 Dec 2022 07:01:54 +0900
X-Iguazu-Qid: 2wGrC6bcpHm6ekEAvW
X-Iguazu-QSIG: v=2; s=0; t=1671832914; q=2wGrC6bcpHm6ekEAvW; m=PvWmES5fybsj6Xei3S0j3b0DJTXW+lf8vL+ay7g7R+8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 2BNM1pNr038305
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 24 Dec 2022 07:01:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/pj/+r0Zqqwyc5LAWcy2dZk2ICkUIpAHAgrAfTEU5TcxreM59Qb9xK4geyoxTCR9D9VPHTW9vyzH9GoazA/Ee+mTO2V0JYNHLtFYszc2sVe+4ivctT44LlwWbUcsM4dl08W3rmLax61wjrOFp8UXoQYwcsdY2zY2vzHVnY+92b8++4YndHj1Q+vhNYBFwH+neWwkwO7opcZSnkk2NPrnzAVNYDLTorCEuKNdt/UyqD0h14W4wCOs0AtyDVUN+YnQJ+HkZZ6NN5mM1hgnfPomjRip+T/tpYkxszBMiA5TVy0KqKNPS/2yH/3KKLpZeBkxsR5JmBWRH1esHu9O1azgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FErFTtBvYVkRQWzIEMGUhafnYqEa8fQR+qXPJAb33qY=;
 b=hdvmzl5sAcCvwgT5q1xwYn/PkutKkQPhKzwoPibqpYp8o4wbCI3lvTbZBL6ovZlMMqZFt5kne6YJViIboUuhr5DOeZzineeCV+DZ7XYjeA3NIo0hKKQxRAiLDWsWS018U7O25q8rFYujLN0c2bYdYUqops/+BtdslE2ulxXy3NBqz6TDzBttBgsEAjlmJLjwl3WdX3UuFNRlwTjnA4Fu4Wc3f1sX4NuPnB9uhvPA32ZJYwCpErsDPZtEUy5Z+31IxUbUqoJjFroFmAKz3ZqYuZPqPXRHDNdgUSy4OWs9kfOPIbP0QPCdI2fUUSxsBkRbHLkKWxFsisADGRxpZvGlhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.269-cip88 and v5.10.161-cip23
Thread-Topic: [ANNOUNCE] Release v4.19.269-cip88 and v5.10.161-cip23
Thread-Index: AdkXGb+jXVyJXHKyRq21A4DaSwySbg==
Date: Fri, 23 Dec 2022 22:01:49 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94202835F51110028D149D8E92E99@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB9988:EE_
x-ms-office365-filtering-correlation-id: 5db074e6-227f-4688-4ea9-08dae5314a6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oYB8PMjQ/T1dpHydhYi4fUtK4OB0TpzkC06RFSDHWnUvcLPwXptyJhGQ3YrPONSfeYIk5y/0xppeh0wSanJeNbcwkJaB5L3HjKSF2b9E09G3VoLEHjVG2oJWx+jFeXrPOrMU2n0HfkWWcs6+UL4BVrszGu2Rxaa54nb2BWTar6ctgxMEq95hh114Fp01xZPJR5iNBjHg+UDm8VvFvlsZQA4r1GkTEg13DqTBxspkov2jhAruG+SRQqIDkOSnlFkx568DU6ZfHTOtAioQtCAVf4fnkqCBswuY8UIxgCP75ixT4Z8Tg8GULpeEwuXwG1WiG3fIa49L0FrDIrydGrrYFTpUOMSI0i9BmyoFLG3W7ElwoMX8Z2vJCoC5Tx0Z7E63Z/SBmQgDlEycWkEdQ8pIlpV4RBVvEF2a+SZ4z/DDqSDmZuCtvS0Bulp7HURzO2B3olUyZAcVG4gycH3RZaJl7JWIaW6PqzcyhDanY0tgcObXa1LPsrtiKmf8ZUAREJqeXpgFjZ36p0j7rnEmIwBYiSccLG9R/b0THYGtXzbcmhzodGeGLMGA76ljMkJyTvHYti31cxHyjAqQNOsVGS45BJ71vFhF2RvLsZrflCnhFW34ZZmqFRwuTcxP9CXcGv3nL2tLjraxV1hb1oSml9hX5/SE+qNN9xJllf6CXbF28M9vYKZEWaboQgw3cE+RWRmJ4I0afyYJKaFCZWRxD3HCUiQlYjfX3B1q91+qrr2uYtM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199015)(38070700005)(316002)(2906002)(54906003)(6916009)(55236004)(83380400001)(478600001)(966005)(7696005)(6506007)(86362001)(55016003)(9686003)(71200400001)(186003)(33656002)(26005)(52536014)(8936002)(38100700002)(41300700001)(122000001)(5660300002)(76116006)(66476007)(66446008)(66946007)(64756008)(66556008)(4326008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZUF6Y3Nsb0oxdUNCdTNxajRZMlMyRVRJQVdwMDR0ZXJLWGZESnNQdmpI?=
 =?iso-2022-jp?B?UFRDb1hzVUtQQjdvMW03S0VWZFVBQXUvd1hQcmdLL1YvQVRXTUE5ZzNM?=
 =?iso-2022-jp?B?bm1QdzArQ0I0R211OWpXKzNtV1AzOThXeTI4bjhLYXkva0NKdGEyQVIy?=
 =?iso-2022-jp?B?b2Y5NE96K3FVV2dvZmhVaDN2d2wrTGFyZzkwRzJqRkdqU3IrK0M3YS9P?=
 =?iso-2022-jp?B?dWRRYnBDZTFPV3hGTHI2U0poRFR6USsvRC9RQXd0Q25lTFVFZXd2Rkcv?=
 =?iso-2022-jp?B?ZzZNTk9wT2lHMmNEUDd5M0VXQW1hTmVXbG9waXFtNGVHNCtxcFVORi91?=
 =?iso-2022-jp?B?SmFjTTUyWm42bXRBS1VvSjVubkc0NURwdHk1NnVabUVldFh4WHZGcUtp?=
 =?iso-2022-jp?B?SDZiQ2krR01BVEJ5bHdkcXppN2NWS3Fmb1BaR2FGSEt3L20vSnFOZ2sy?=
 =?iso-2022-jp?B?SVlHdXJjUXgvQkhUd3MxTWdNbTRjdDBRTkVMZUNaUXNaMHlEcjgyNmd6?=
 =?iso-2022-jp?B?UzcvNUhYZGFaalhhYXpDNkNXQk92SWRSeWMxQUNQcE5ETGVONWdCTWZQ?=
 =?iso-2022-jp?B?eWlweUdkZFd4VDh6b2xxbkdhdDROdnZaZDZFTGFqMHM4TFhQR3BIZStC?=
 =?iso-2022-jp?B?cGtCZnRrd1ZwNmF2Q3hucEpibG5wcGhnMEEvVEdoVUExRjNaTE9lbzBN?=
 =?iso-2022-jp?B?ekhtalhDc0YvaTB0RXVTWHYyUFc2Q2dBMU1EQUs2ajlGZkRYZG0xdGtI?=
 =?iso-2022-jp?B?ejBWWnBnbnpIY2VwNmdRYnFzbFFGVXllL2ZkN0cxZEthTmNpTUppZ01h?=
 =?iso-2022-jp?B?RmlHcU5DNWxUY1RxQ2V1d1VpR0pqVzcxSXVkMk1NQjIwWnpza2hmKzJk?=
 =?iso-2022-jp?B?WXJXQitPL3BsS2NHYlFENEo3MHY2N21YZUpCY0duRTdzMzQ4S3BqY1J5?=
 =?iso-2022-jp?B?QWVGWXBhdDRvWXcweEpDWDJjUm0vSkhUamJUdlMvbmtUeDlLZGFReWcr?=
 =?iso-2022-jp?B?OG5KVHR5TzJEYU5GS2NYd2VkSks4ZWFVVTE4OFVFbWo1dHg5d0NvSlRn?=
 =?iso-2022-jp?B?a1Z5STJ5RCtmRnVORXBhM3graGhwTGZPY0VtV1NiR3dURHVwSUxnaDZO?=
 =?iso-2022-jp?B?dUtwWTNhWmZCYzV4aVM4KzMrblFSV0VQZjJNU0FoNm1ISFRwTzNiRFJ4?=
 =?iso-2022-jp?B?cG84bWJJbk5MRWpaZm5VMXBoTGdrb3djeTRPcnhXWUpjdnNlNGRnUmpR?=
 =?iso-2022-jp?B?dFFNTEwvQTI0dlJidDQxb3BXMTdkek13QUo3Y3RmK1BoQklRZlNtUGU0?=
 =?iso-2022-jp?B?NklndGM5cCtYS3NsWURiTmx3UjhCWHJEZCtodG9sVGNyblFyZ096enRS?=
 =?iso-2022-jp?B?ZFIydHJZVXJwYTlVWFVGSHk4RU11cmVDaWRiNVRrRnMwdmd1NWlWTHcw?=
 =?iso-2022-jp?B?b2g3TTIvZFgzTGUxZ0R1VDYva3A0Zm9QZ21vSFk3ZnVHT3c3eXhFd081?=
 =?iso-2022-jp?B?QTFrdklsaWpVaUx0MFZyQU1kbjd0Q3E1b0IralNVcG1ZWk1PUTZXTmpV?=
 =?iso-2022-jp?B?TlBiL3NmUXF2VkM3U0tCYUZ2NlQ3K2Nrb2ZMOWVCSHVNUS9teExmUUY1?=
 =?iso-2022-jp?B?dStSQXlXL2NmbTBKdTdnaHViQnhQRWhDb09naVE3S3pnT0FGQ1B4dWRO?=
 =?iso-2022-jp?B?a01UL1RxYUJSUWw5TEZXcXZ6bU5jVjhkZHNnR2RyYkF2WWZTOGJhL2dR?=
 =?iso-2022-jp?B?VnZENlRTN0NnaW5qRGJPc1gyTWtZSG9YdytibTVWVmVxQkEyL2JVcFRR?=
 =?iso-2022-jp?B?cmdUeDA3ajJMYWRGVDRMZGNrdjR2b0tHK1YyLzVXcThrVDhicFNyWTdq?=
 =?iso-2022-jp?B?dThUSG93YnpManNEU1lZMVRrRjd1YmhlbXAwVDMrSXhRWnYvbVFkdWdM?=
 =?iso-2022-jp?B?Z2N0ZHNmM3hSYytvVTNXUHVPNEUxZ3dJQmFTUENGZ04vU0tERGJyQU9B?=
 =?iso-2022-jp?B?UFFiZVdBb3JlTVBLY3dRVjY0dk9Va0xEMW9WaTY2WGFPNFFYMUlLZDZS?=
 =?iso-2022-jp?B?clloazNXWVhieDAxSzg1cFZVdnRPb2Qrd2Y0TUF3YzNxc05oc1pQU2lS?=
 =?iso-2022-jp?B?VnpzYWJnZFF3N3dwNTUwcm41aFFYTUU5WUgraW13Y0JUMXpTU29DWTVH?=
 =?iso-2022-jp?B?NUpjN3hOU296MExwbXR0TWw3alVmOXh4Ym5WQjFtUUVHRUpseTVtR3J2?=
 =?iso-2022-jp?B?NHlwUTVmQ1lHOENMbG1VVVpnTWFnMlA5OGdBMHBxY2lmOThESWZ2MjBN?=
 =?iso-2022-jp?B?NWV5RjNpbnJvNElOeHNqMjg5amx0QXY2bWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db074e6-227f-4688-4ea9-08dae5314a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 22:01:49.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9AZhmgKgFNddx7Vq6Jz8xSvFNVc6pJKF8TWoa69jJWwIF4oodKWhF11SloGVYtaHeCoOID5B7Wa3GgBTtDvmV1rPvV75FnP0uKNwFV+0741cTHBvJRCc6CBN1t9EkNc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9988
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Dec 2022 22:02:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10264

Hi,

CIP kernel team has released Linux kernel v4.19.269-cip88 and v5.10.161-cip=
23.
The linux-4.19.y-cip tree has been updated base version from v4.19.268 to v=
4.19.269, and the linux-5.10.y-cip tree has been updated base version from =
v5.10.158 to v5.10.161.
The Linux-5.10.y-cip tree has been fixed rcar_canfd.

You can get this release via the git tree at:

  v4.19.269-cip88:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      68472fb565eddeb233132b8be94440d06330ffbb
    Fixed CVEs:
      CVE-2022-42329: xen/netback: don't call kfree_skb() with interrupts d=
isabled
      CVE-2022-42328: xen/netback: don't call kfree_skb() with interrupts d=
isabled
      CVE-2022-3643: xen/netback: Ensure protocol headers don't fall in the=
 non-linear area
    added commits:
      CIP: Bump version suffix to -cip88 after merge from stable

  v5.10.161-cip23:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      986414929cfe870aedc5685f5ed4201f5032ca3e
    Fixed CVEs:
      CVE-2022-45934: Bluetooth: L2CAP: Fix u8 overflow
      CVE-2022-3545:  nfp: fix use-after-free in area_cache_get()
      CVE-2022-3623:  mm/hugetlb: fix races when looking up a CONT-PTE/PMD =
size hugetlb page
      CVE-2022-42329: xen/netback: don't call kfree_skb() with interrupts d=
isabled
      CVE-2022-42328: xen/netback: don't call kfree_skb() with interrupts d=
isabled
      CVE-2022-3643:  xen/netback: Ensure protocol headers don't fall in th=
e non-linear area
    added commits:
      CIP: Bump version suffix to -cip23 after merge from stable
      can: rcar_canfd: Add multi_channel_irqs to struct rcar_canfd_hw_info
      can: rcar_canfd: Add postdiv to struct rcar_canfd_hw_info
      can: rcar_canfd: Add shared_global_irqs to struct rcar_canfd_hw_info
      can: rcar_canfd: rcar_canfd_probe: Add struct rcar_canfd_hw_info to d=
river data
      can: rcar_canfd: Use devm_reset_control_get_optional_exclusive
      can: rcar_canfd: Add missing ECC error checks for channels 2-7
      can: rcar_canfd: rcar_canfd_handle_global_receive(): fix IRQ storm on=
 global FIFO receive

Best regards,
   Nobuhiro


