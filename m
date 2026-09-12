Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1495C88E45
	for <webhook@archiver.kernel.org>; Sat, 12 Sep 2026 04:02:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.343.1789185753008800043
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 21:02:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=Sk+aRPgI;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1789185737;x=1790395337;bh=
	99yWcBns3I8IbhebJ1AB4uItfy4Aa3xAqZjSKG0rfpQ=;b=Sk+aRPgIVIyPjtfk8iNWyr7MlNeIvd
	1D922BTLKFKuOj9qGvIZG4SbsXVu3D+NizyRjmv113G+9KswvJAPU2c3lja64FhnSLpuMeghzxhfi
	eFX0YFEpgoO8Xd/yyWyKCr4d7SiTu6XgOKpql8Rl3W9XPmJXfBdvbpZdQO4wzIvAOYgjNahddTcNO
	XVJdCllWY1fkbyEqVXJ5ezjJ/GZBujwjUkGNMdie/6V7OwkzyW/BZ9mUQJ6i2dQ1KrC7P8QEMZor6
	+PUu31L5BjyElqNHwGUpZvmP9A4LeXFfJxNVDfULlkey3Ztfjmwc4JwZC4AKTmCKAC4w/Lykf6oac
	L6ug==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 68C42GwZ3073565; Sat, 12 Sep 2026 13:02:16 +0900
X-Iguazu-Qid: 2rWgSEmgZAgAW0s2oC
X-Iguazu-QSIG: v=2; s=1; t=1789185736; q=2rWgSEmgZAgAW0s2oC; m=6FJoc6kD4pYLOS5zBN/JD7MC9B9PEX/IajK3THh8Qtk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hhd5z0h8lz1xnf; Sat, 12 Sep 2026 13:02:14 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aChJlXdktYFxe2oLqccqQEWDvvVlgKDMEu96kYHIGyeGz2AvAxtZ6/lBxm6AuU2u7BCVtlmNigFrB1EwCT7TaOoFoBE3rqyj7HdGFv9/aeaZtfFDuhrgZJcY1QWTqF8/10CYoU+fe3OhGe2uuGkbGrJT0T7cUpSxA2iMMO2m/92GwLYKzlK02IvFxmQ0bVxc8DiE8yJWuV3tXvatf/KVx58W8NFYpwZawE003SXFv3xTX9CE0EZwP/sjQ30KqbbVdafdmZq6v1X7wXEY4xXqeawYZNI77GnoMLZZGjR1sh/DE7cVmfA4tzFVjBC8s+5nn1NLNGggwyZ+p2N6zmmRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXf0TSw1EvFCntIhmtVL5OMnFOvpaNAsADrTUll1G9U=;
 b=wSFXDqN5rCp/eyBIdxIjC6ejKmEUV/TDHIrQ9hc9GteomJkwtDGU18Wq5CfSmXYfZadfbvT5XosKAkFh3hEJqqq9L+bPrO+L/MKP9z3zxG83Ds9xKcj+Fb+kTQs/67bHFYoJ2kY8UqqH5Uw8nBp2MXdQomirxTMbla5FlPEiyLC/FUhac7zqGOAbGNCrJsrqt68w+tY96VdbbkPZJXtJKWUPuSoiCq4QlGM+gCZGaZZpKXskwlDmiBNozxysY2d2NQP3beqNdiHhr4E3O1myBAzwAduY/hLLCEXhPzZ++gn+pxrpFSibHi8f7m0DfisIZGSiRadTzbxB4UuWUhm2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.268-cip77
Thread-Topic: [ANNOUNCE] Release v5.10.268-cip77
Thread-Index: Ad1Ca3AQniFmm1s8TYal//mO2E8Pfw==
Date: Sat, 12 Sep 2026 04:02:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481855B57BCC3D4C67E04E23CDBD2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB13433:EE_
x-ms-office365-filtering-correlation-id: 9469719f-ee40-4219-b4bf-08df10829ebd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|3023799007|10067099003|11063799006|6133799003|56012099006|5023799004|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 oyIt+d5wrIotlf860ttYSVOPEGWsCQyWmseWMdeYsgv+jHsfJPZGrxn99MjBz53vfo67AzuiLVx3jutmDQKhgpGYDGpOhBbzFfiNKXVC2l7xGnt81SKcyDkhQGQHkOyIxpjbfMpBLKWkG3p+A0npoAyrq0fLcYoCFTe9pgcy/6v3chNXNkOJS2ShpYY/H40mBJ7ZiQaUXIBPO8O0ZvWDQeX0Ttf0e/Jzy0CJBILKrcCKgFnlWRGHT+usXIJXH4j263NyELTPABmDFf63DICOlI2fDBeulQIeAGXvms+X2jB5NQJ4L63pbkiOnw0cBQWDKdlPu2x/MhrWK5swcFH2/0HSssajSl4sJ7eWySMeJhfHkX3wGu0g7ocHjbeBYVkIaYEUXwP46ZrbVlOAxs3nVPJvDatBVDIPzxtjbM0Z6KypaakIFbC1pW4AHYnKiOPfay/1dZBEYft04Js9NfWzEsh0/PTXWYk2qciqF/JgnWODo0YyFZkgooXRY3TcVC4b6pSeRCFzbwhG1UgdV0ILHW2kOlgmqFwWBx6YVg5p8hHVccAFNfPtK/13m6Pqjkj/VKlrY02bbaakrqlNC+jrg8LPjfwZAVuTcHdB/xiW5T+FUI4i2VKcuBEs7aOFVt1JL7baV4iK6WAqL4AqHHayZHaYWugBWOxE0Y8VdtKW+OObQj+Xj5rTiX6JMhY5JoXf7fim2Fs2XhsZoYEmzgvsW0T1n6P3+SAsk4HTSWuFrOQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(3023799007)(10067099003)(11063799006)(6133799003)(56012099006)(5023799004)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NjIvRzZ2cjFRdnNOSnFiVjV0TUVpdmswT3RDa05DdU1mY0VJVTRPL0l3?=
 =?iso-2022-jp?B?bnFVRDFlbWF4bmd6TkZVK1RlTkYzMlNyOWg4aU9JUzB6dS9QdGFEOUZu?=
 =?iso-2022-jp?B?QUJROTVROCtmL0pFL3lRWkJ1Y0VSaUpRcUZDSlZaalZEdEVCUEIwQ3ZK?=
 =?iso-2022-jp?B?alQ1U0loN0RtRFhQYWRaMVZZeDF2dGx4dTVsTXNjdTVJeEtpUmhIcUlP?=
 =?iso-2022-jp?B?L2l3anF1a1kxMjYvSDErOEQ0R2FzR0VGLzNtVFhGTXJLbW91b3MwMDZI?=
 =?iso-2022-jp?B?VVA4YUpIOEpwTnc0bHhHYzJtd2JZTjJCdHpIRG11MWlrczcvemtoZC8w?=
 =?iso-2022-jp?B?cEhiazZoNzJYYkxhRGpWbHBxbmJRaGhBVC9mZGYySFhNbk1vK3dvbkRS?=
 =?iso-2022-jp?B?V29yTGVONVNXdGR5MFd5cTFkNmlrNWV1SDEveVFVdW0yazJ0a0NzQVNj?=
 =?iso-2022-jp?B?Nk9jdk5VM1NHTHVZaTEwQTBYUWpHV1VndjcxcldzanRwbkJXdHRnaURx?=
 =?iso-2022-jp?B?T2cyWGZOSGhpWXFMSTFKRmRob0FSUVVpdlhPSWNUd2J4VHBaQXhzUVNO?=
 =?iso-2022-jp?B?a3NTV3lmS0wzMnp3Y3JBSmw5NlNpK21VVGdEMll5RGtaT3dnL0hwRkZS?=
 =?iso-2022-jp?B?L3QrZmlXVkladUt6bldrSzdOVUQrRnIrUnFPTHZFb3lKRDAxTmhJbS9m?=
 =?iso-2022-jp?B?eWo3NTdMVExqdmc3OWswU2lMR3YvZStwVm9aWk1kNElHcFNuWVdJMm84?=
 =?iso-2022-jp?B?aENUSjBNMUdBMVIvVHBTQ0RKeThtMWx4M1BoZk5oU3YzdFQ1L0VWWDli?=
 =?iso-2022-jp?B?NW5zNVQxU1hLZlNYMmhXR2JOdFp6Q2dFNTZXVlNIdDVsMWIybjdQd0FI?=
 =?iso-2022-jp?B?ejkwV3FsMTAvNlJqeEY4OGlwb3hoRDBwQ1g5YjNla3RBMFkzK1Rna2NN?=
 =?iso-2022-jp?B?ZXRhZ2JZcnlDWS8zd2U5bFhKQ1dQYnk0RXhGczVkeVBuNUh0ay9QaXR2?=
 =?iso-2022-jp?B?WWc1cTJqWFJKa0JmakdicWprVVNuT1pSRDQyYTBqY0Npd0QrNnpPQVVQ?=
 =?iso-2022-jp?B?ZWV1SzVJcTdDTWIxQXNZM2RCeHhac004UTkrd0YvN0F1K2R1b09hMkFJ?=
 =?iso-2022-jp?B?TEpxVlNkMlhUbSt4eVpMWlhOYm9oNEQwT3YwWG94S3UxMmgxeFFMNFEy?=
 =?iso-2022-jp?B?dkNNdDlsZkpZYzZOMWJwLy9HV0xkRGtWUTN1eEM3UHhzU1g1SUdZSWpP?=
 =?iso-2022-jp?B?MnQyS1NGeHY0c1pQL05uZ2pCRGtlb0hWODl1WUhGU1Z3dmpRVkU2dlY1?=
 =?iso-2022-jp?B?QkxNS1Y2MFhuK21ObGhQQmxSNmp4Uis3WFJmRHhLRTZUK0FaQzdQWFdi?=
 =?iso-2022-jp?B?eHI0RjFSejgyd1psQjBldFpTZlpWd05NNnNIUHo5aWpldXZSMGpJd2N3?=
 =?iso-2022-jp?B?SGkyR1pjbmZuMyt4NkZUL0tZTEcrMENGeVYxdnIvQVBxNVQ4NGVVMTRI?=
 =?iso-2022-jp?B?VDRMTkYra0haQ0w3RG9aYWpHTnpDZVJ1bTE5QjdCcU1pTWExanhHZXgx?=
 =?iso-2022-jp?B?b1o2WTY1ZHZWdnBLTjJXRmw2UE1PS24ra01vQ2YxSWpwVW1HTnN1b2Rn?=
 =?iso-2022-jp?B?K0VxdUY1L2dLWnVUK3VlTzU5b2ZObGVlTzZjeTZFVElHbEVnMGZ0RFI5?=
 =?iso-2022-jp?B?aWdzTFEzUnYvK0lpUm8vNU0rSWFHbHQrN1FVSU5OWDRuT09PRjc5S3lZ?=
 =?iso-2022-jp?B?dDU4QmQyb2Y4UDEzM3Y3YW42aWwxZmNtbmxDa291MWRCS1lCbDM3UFRV?=
 =?iso-2022-jp?B?ek9ya0kzNUo5dS8vWU04MytsWlliN0s3N2d2VjJYM3g4L3U0aStoWnVi?=
 =?iso-2022-jp?B?NmhZTlVreG9ic0tRZGxTalM5N09QR1BRaS9hM1oyNlVHbERwMVo0K2lP?=
 =?iso-2022-jp?B?aEdGUXVvRk9hSFFwZUxlWFNqNU00S2gvQzVva3FoUG9rcjdZdkxqUDFp?=
 =?iso-2022-jp?B?MjNjbzUzdldYYVhCM0lPRWh3T2tmc3U3ZzRXRVR1aGExUkpxT2JES0Yr?=
 =?iso-2022-jp?B?NS9BcTN4UXZMUFVtTHhLci9zNjZ5RE1FcHpSaUY4N1lpZTRrMms4Vmlx?=
 =?iso-2022-jp?B?ZlovbFhUY2hCeVFhbGV4d0hOUGE2cm5OTGpyTE1xRlJVTzRlWjc5Snhj?=
 =?iso-2022-jp?B?Q0l6U1luWHQ5QWVpTXFLeVYyWnhkQmJiTkVwdHdzdFFMR1Q3ZlozVk1P?=
 =?iso-2022-jp?B?T2lIM2liWGlGT2ZmMFRSMHFZN3Z6c0N6VUg0Y3YwVXdtYWd3bFRhV25z?=
 =?iso-2022-jp?B?bm1RZU9meEVTL1hDaUhIRytla0ZjS3BGelZZMXIwZHNkSmdub1prQzds?=
 =?iso-2022-jp?B?THFxbkRocElhenA1ZHk1d3NneWdSdzJrc0RITVlLWEhpNGNwTjNPWGF6?=
 =?iso-2022-jp?B?QmlzUXRYUk12OUIxektOTjR1SE93N0N5KzJBa3RrSnlkc0cvbzBLZ2ti?=
 =?iso-2022-jp?B?U3FZSkRVVkNLL29ic3JJZFFRN2Zia2xHcmlhLythbXZpQU5ZTmowVVNV?=
 =?iso-2022-jp?B?OGROZ0grZz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	tZN+7sIBSqkQBIU3lhLLiMXXUvQ5Y3510zoWJ2fG8XSvIVJYzj5pslKQHmz2RdkhMp2enBmAuA80Am2Y0JAsIs+dvcGPmLXVzTjhy0tpo3GlzuoTPrEveb5Eb3/GkMHQ2U/Nuz3B/q3yrIziJc0y72a7NrNsPDOOj+I1MXMySfMSS6vv/AhVk4jYd+5zeVxSfsxmdUCc8IdRjudCtOyonvQtzJq/I6i6wl/jU5uPX6W1Ogr4EsLqrLvX+Lw+AI0Pu2khbKExCBh2WfeGP/dT+IQwqjXRxi8xgAs+UHnLGGTQeE0t3CHMadYEV30BLty7CVZBGFVqoiZrhy2V0VcL5g==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9469719f-ee40-4219-b4bf-08df10829ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2026 04:02:10.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSf6ryH7Qk5rnnFzpLty1stlP1RjD050QHgQk178w0HAS+eCdQDgXsZVQBSaW9TkcntK+Qi4Ixw5Uiax5RJzhfSk8l88STeM+reF9kIXCnhjA6pL4Xf6nqoruE96T9EL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13433
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 12 Sep 2026 04:02:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24153

Hi all,

CIP kernel team has released Linux kernel v5.10.268-cip77.
The linux-5.10.y-cip tree has been updated base version from v5.10.263 to v=
5.10.268.

Information about this release is as follows:

  v5.10.268-cip77:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      2a254b6d597775ce6625a742cdfe7fffd699631c
    fixed CVEs:
      CVE-2024-50125: Bluetooth: SCO: Fix UAF on sco_sock_timeout
      CVE-2024-58240: tls: separate no-async decryption request handling fr=
om async
      CVE-2026-31408: Bluetooth: SCO: Fix use-after-free in sco_recv_frame(=
) due to missing sock_hold
      CVE-2026-43491: net: qrtr: ns: Limit the maximum server registration =
per node
      CVE-2026-53090: bpf: Fix ld_{abs,ind} failure path analysis in subpro=
gs
      CVE-2026-64427: HID: logitech-dj: Fix maxfield check in DJ short repo=
rt validation
      CVE-2026-64434: Bluetooth: L2CAP: Fix UAF in channel timeout by holdi=
ng conn ref
      CVE-2026-64535: nvmet-tcp: Fix potential UAF when ddgst mismatch
      CVE-2026-64543: tipc: fix use-after-free of the discoverer in tipc_di=
sc_rcv()
      CVE-2026-64562: KVM: nVMX: Hide shadow VMCS right after VMCLEAR
      CVE-2026-64563: rhashtable: clear stale iter->p on table restart
      CVE-2026-64564: sctp: don't free the ASCONF's own transport in DEL-IP=
 processing
      CVE-2026-64565: Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_=
process_data()
      CVE-2026-64567: btrfs: reject free space cache with more entries than=
 pages
      CVE-2026-64569: mpls: fix NULL deref in mpls_valid_fib_dump_req() on =
CONFIG_INET=3Dn
      CVE-2026-64571: wifi: p54: validate RX frame length in p54_rx_eeprom_=
readback()
      CVE-2026-64572: ipv4: fib: free fib_alias with kfree_rcu() on insert =
error path
      CVE-2026-64579: xfrm: policy: preallocate inexact bins before xfrm_ha=
sh_rebuild reinsert
      CVE-2026-64582: RDMA/rxe: Fix a use-after-free problem in rxe_mmap
      CVE-2026-64584: usb: gadget: f_midi: cancel pending IN work before fr=
eeing the midi object
      CVE-2026-68104: drm/amdgpu: invoke pm_genpd_remove() before freeing g=
enpd
      CVE-2026-68106: drm/amdgpu: fix division by zero with invalid uvd dim=
ensions
      CVE-2026-68111: drm/amdgpu/gfx9: replace BUG_ON() with WARN_ON()
      CVE-2026-68115: drm/amdgpu/gfx10: replace BUG_ON() with WARN_ON()
      CVE-2026-68117: tipc: clear sock->sk on the failed-insert path in tip=
c_sk_create()
      CVE-2026-68121: pppoe: reload header pointer after dev_hard_header()
      CVE-2026-68123: openvswitch: fix GSO userspace truncation underflow
      CVE-2026-68125: mac802154: llsec: reject frames shorter than the auth=
entication tag
      CVE-2026-68127: ila: reload IPv6 header after pskb_may_pull in checks=
um adjust
      CVE-2026-68131: rbd: Reset positive result codes to zero in object ma=
p update path
      CVE-2026-68135: net: hip04: fix RX buffer leak on build_skb failure
      CVE-2026-68137: net/x25: fix use-after-free in x25_kill_by_neigh()
      CVE-2026-68140: net/iucv: fix use-after-free of a severed iucv_path
      CVE-2026-68141: net/af_iucv: fix NULL deref in afiucv_hs_callback_syn=
()
      CVE-2026-68142: geneve: require CAP_NET_ADMIN in the device netns for=
 changelink
      CVE-2026-68143: net: slip: serialize receive against buffer reallocat=
ion
      CVE-2026-68144: phonet: pep: fix use-after-free in pep_get_sb()
      CVE-2026-68151: binfmt_elf_fdpic: only honour the first PT_INTERP
      CVE-2026-68153: libceph: remove debugfs files before client teardown
      CVE-2026-68154: libceph: reject zero bucket types in crush_decode
      CVE-2026-68156: libceph: refresh auth->authorizer_buf{,_len} after au=
thorizer update
      CVE-2026-68157: libceph: guard missing CRUSH type name lookup
      CVE-2026-68158: libceph: Fix multiplication overflow in decode_new_up=
_state_weight()
      CVE-2026-68160: ceph: fix pre-auth out-of-bounds read on snaptrace in=
 ceph_handle_caps()
      CVE-2026-68171: [REJECTED]: arm64: syscall: Ensure saved x0 is kept i=
n-sync with tracer updates
      CVE-2026-68175: tracing: Fix resource leak on mmiotrace trace_pipe cl=
ose
      CVE-2026-68176: tracing: Fix mmiotrace possible NULL dereferencing of=
 hiter->dev
      CVE-2026-68180: intel_th: fix MSC output device reference leak
      CVE-2026-68182: comedi: comedi_parport: deal with premature interrupt
      CVE-2026-68183: firmware: stratix10-svc: fix memory leaks and list co=
rruption bugs
      CVE-2026-68184: cdrom: fix stack out-of-bounds read in CDROMVOLCTRL
      CVE-2026-68186: binfmt_misc: set have_execfd only once the interprete=
r is opened
      CVE-2026-68187: exec: fix unsigned loop counter wrap in transfer_args=
_to_stack()
      CVE-2026-68188: Bluetooth: RFCOMM: Fix session UAF in set_termios
      CVE-2026-68192: wifi: brcmfmac: make release_scratchbuffers idempoten=
t
      CVE-2026-68195: wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buse=
s
      CVE-2026-68196: wifi: wilc1000: validate assoc response length before=
 subtracting header
      CVE-2026-68197: wifi: mwifiex: fix NULL dereference when the AP has H=
T-cap but no HT-oper
      CVE-2026-68199: wifi: ath6kl: fix OOB access from firmware ADDBA wind=
ow size
      CVE-2026-68204: media: vivid: check for vb2_is_busy() when toggling c=
aps
      CVE-2026-68209: media: sun4i-csi: Return queued buffers on start_stre=
aming() failure
      CVE-2026-68212: media: saa7134: Fix a possible memory leak in saa7134=
_video_init1
      CVE-2026-68213: media: rtl2832_sdr: Return queued buffers on start_st=
reaming() failure
      CVE-2026-68214: media: rtl2832: fix use-after-free in rtl2832_remove(=
)
      CVE-2026-68215: media: radio-si476x: Unregister v4l2_device on probe =
failure
      CVE-2026-68216: media: pwc: Return queued buffers on start_streaming(=
) failure
      CVE-2026-68217: media: pwc: Drain fill_buf on start_streaming() failu=
re
      CVE-2026-68218: media: pci: dm1105: Free allocated workqueue
      CVE-2026-68222: media: msi2500: Return queued buffers on start_stream=
ing() failure
      CVE-2026-68223: media: meson: vdec: Fix memory leak in error path of =
vdec_open
      CVE-2026-68226: media: cx23885: add ioremap return check and cleanup
      CVE-2026-68227: media: cx231xx: fix devres lifetime
      CVE-2026-68229: media: cedrus: skip invalid H.264 reference list entr=
ies
      CVE-2026-68231: media: airspy: Return queued buffers on start_streami=
ng() failure
      CVE-2026-68234: drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_r=
eserved
      CVE-2026-68249: drm/amdgpu/sdma5.0: replace BUG_ON() with WARN_ON()
      CVE-2026-68250: drm/amdgpu/sdma5.2: replace BUG_ON() with WARN_ON()
      CVE-2026-68284: bpf, sockmap: Fix cork use-after-free in tcp_bpf_send=
msg()
      CVE-2026-68294: net: qrtr: restrict socket creation to the initial ne=
twork namespace
      CVE-2026-68297: tipc: fix u16 MTU truncation in media and bearer MTU =
validation
      CVE-2026-68299: vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Gene=
ve packets
      CVE-2026-68300: sctp: auth: verify auth requirement when auth_chunk i=
s NULL
      CVE-2026-68304: wifi: brcmfmac: fix 802.1X-SHA256 call trace warning
      CVE-2026-68313: tipc: fix infinite loop in __tipc_nl_compat_dumpit
      CVE-2026-68315: sctp: validate stream count in sctp_process_strreset_=
inreq()
      CVE-2026-68320: sctp: fix auth_chunk_list capacity check in sctp_auth=
_ep_add_chunkid
      CVE-2026-68322: rds: Fix inet6_addr_lst NULL dereference when IPv6 is=
 disabled
      CVE-2026-68325: iommu/amd: Bound the early ACPI HID map
      CVE-2026-68326: wifi: mwifiex: bound uAP association event IEs to the=
 event buffer
      CVE-2026-68327: wan: wanxl: Only reset hardware after BAR mapping
      CVE-2026-68328: nfp: Check resource mutex allocation
      CVE-2026-68335: rds: drop incoming messages that cross network namesp=
ace boundaries
      CVE-2026-68338: net/packet: avoid fanout hook re-registration after u=
nregister
      CVE-2026-68344: usb: atm: ueagle-atm: reject descriptors that confuse=
 probe and disconnect
      CVE-2026-68349: wifi: carl9170: fix buffer overflow in rx_stream fail=
over path
      CVE-2026-68350: wifi: carl9170: fix OOB read from off-by-two in TX st=
atus handler
      CVE-2026-68351: wifi: carl9170: bound memcpy length in cmd callback t=
o prevent OOB read
      CVE-2026-68352: wifi: ath6kl: fix OOB read from firmware IE lengths i=
n connect event
      CVE-2026-68353: wifi: ath6kl: fix OOB read from firmware num_msg in T=
X complete handler
      CVE-2026-68354: firewire: net: Fix fragmented datagram reassembly
      CVE-2026-68355: wifi: ath11k: fix potential buffer underflow in ath11=
k_hal_rx_msdu_list_get()
      CVE-2026-68357: watchdog: pretimeout: Fix UAF in watchdog_unregister_=
governor()
      CVE-2026-68360: hwmon: (corsair-cpro) Stop device IO before calling h=
id_hw_stop
      CVE-2026-68363: wifi: ath9k: hif_usb: don't dereference hif_dev after=
 re-arming firmware request
      CVE-2026-68365: USB: serial: io_edgeport: cap received transmit credi=
ts
      CVE-2026-68366: usb: gadget: uvc: clamp SEND_RESPONSE length to the r=
esponse buffer
      CVE-2026-68368: usb: gadget: f_ncm: validate datagram bounds in ncm_u=
nwrap_ntb()
      CVE-2026-68369: usb: gadget: printer: fix infinite loop in printer_re=
ad()
      CVE-2026-68370: usb: gadget: dummy_hcd: prevent fifo_req reuse during=
 giveback
      CVE-2026-68373: wifi: at76c50x-usb: avoid length underflow in at76_gu=
ess_freq()
      CVE-2026-68376: sctp: fix auth_hmacs array size in struct sctp_cookie
      CVE-2026-68377: net/sched: act_tunnel_key: Defer dst_release to RCU c=
allback
      CVE-2026-68388: smb/client: handle overlapping allocated ranges in fa=
llocate
      CVE-2026-68395: ata: sata_dwc_460ex: enable SATA interrupts only afte=
r IRQ handler is registered
      CVE-2026-68397: net/iucv: take a reference on the socket found in afi=
ucv_hs_rcv()
      CVE-2026-68402: wifi: cfg80211: bound element ID read when checking n=
on-inheritance
      CVE-2026-68403: wifi: brcmfmac: initialize SDIO data work before clea=
nup
      CVE-2026-68405: wifi: mac80211: free AP_VLAN bc_buf SKBs outside IRQ =
lock
      CVE-2026-68406: wifi: cfg80211: validate PMSR FTM preamble range
      CVE-2026-68410: wifi: libertas: fix memory leak in helper_firmware_cb=
()
      CVE-2026-68411: wifi: mac80211_hwsim: clamp virtio RX length before s=
kb_put
      CVE-2026-68413: wifi: ipw2100: fix potential memory leak in ipw2100_p=
ci_init_one()
      CVE-2026-68425: IB/mad: Drop unmatched RMPP responses before reassemb=
ly
      CVE-2026-68428: KVM: x86/mmu: Fix use-after-free on vendor module rel=
oad
      CVE-2026-68430: drm/amdgpu/gfx8: drop unecessary BUG_ON()
      CVE-2026-68432: vxlan: require CAP_NET_ADMIN in the device netns for =
changelink
      CVE-2026-68433: libceph: bound get_version reply decode to front len
      CVE-2026-68446: drm/vmwgfx: Validate vmw_surface_metadata::array_size
      CVE-2026-68449: ata: sata_dwc_460ex: fix infinite loop in NCQ tag com=
pletion bit-scanning
      CVE-2026-68451: s390/zcrypt: Validate length for CCA ECC private key =
requests
      CVE-2026-68452: s390/zcrypt: Validate length for CCA AES cipher key r=
equests
      CVE-2026-72019: macsec: don't read an unset MAC header in macsec_encr=
ypt()
      CVE-2026-72066: cpu: hotplug: Bound hotplug states sysfs output
      CVE-2026-72113: can: bcm: add missing device refcount for CAN filter =
removal
      CVE-2026-72114: can: bcm: validate frame length in bcm_rx_setup() for=
 RTR replies
      CVE-2026-72115: can: bcm: track a single source interface for ANYDEV =
timeout/throttle ops
      CVE-2026-72116: can: bcm: fix stale rx/tx ops after device removal
      CVE-2026-72117: can: bcm: fix data race on rx_stamp/rx_ifindex in bcm=
_rx_handler()
      CVE-2026-72118: can: bcm: fix CAN frame rx/tx statistics
      CVE-2026-72119: can: bcm: extend bcm_tx_lock usage for data and timer=
 updates
      CVE-2026-72121: can: bcm: add locking when updating filter and timer =
values
      CVE-2026-72123: can: bcm: defer rx_op deallocation to workqueue to fi=
x thrtimer UAF
      CVE-2026-72124: can: isotp: serialize TX state transitions under so->=
rx_lock
      CVE-2026-72125: can: isotp: fix use-after-free race with concurrent N=
ETDEV_UNREGISTER
      CVE-2026-72181: mips: sched: Fix CPUMASK_OFFSTACK memory corruption
      CVE-2026-72392: ipv6: fib6: fix NULL deref in fib6_walk_continue() on=
 multi-batch dump
      CVE-2026-74443: drm/vmwgfx: bound DMA command body size against suffi=
x pointer
      CVE-2026-74444: drm/vmwgfx: validate DRAW_PRIMITIVES header size befo=
re division
      CVE-2026-74453: drm/vc4: Zero the tile state data array before each B=
IN job
      CVE-2026-74455: can: peak_usb: validate uCAN receive record lengths
      CVE-2026-74456: can: peak_usb: peak_usb_start(): fix double free of t=
ransfer buffer on URB submit error
      CVE-2026-74457: can: peak_usb: add bounds check for USB channel index
      CVE-2026-74458: can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): val=
idate received command extents
      CVE-2026-74463: i2c: jz4780: Cache host clock rate at probe to preven=
t CCF prepare_lock deadlock
      CVE-2026-74464: net: openvswitch: fix skb leak on flow key update fai=
lure during ct
      CVE-2026-74465: net: openvswitch: fix potential UAF on meter attach f=
ailure
      CVE-2026-74468: gpio: pch: use raw_spinlock_t for the register lock
      CVE-2026-74469: sctp: prevent peer transport count overflow
      CVE-2026-74471: tracing: Check return value of __register_event() in =
trace_module_add_events()
      CVE-2026-74473: vxlan: use pskb_network_may_pull() in route_shortcirc=
uit()
      CVE-2026-74475: vxlan: use neigh_ha_snapshot() in route_shortcircuit(=
)
      CVE-2026-74478: um: vector: fix use-after-free in vector_mmsg_rx()
      CVE-2026-74480: net: bridge: stop fast-leave after deleting a port gr=
oup
      CVE-2026-74481: mm/page_reporting: use system_freezable_wq to fix UAF=
 during suspend
      CVE-2026-74482: mm/huge_memory: unlock i_mmap_rwsem before releasing =
after-split folios
      CVE-2026-74485: binfmt_misc: reject a flag character as the field del=
imiter
      CVE-2026-74488: wifi: mwifiex: use the subframe length when parsing A=
-MSDU TDLS frames
      CVE-2026-74490: tipc: avoid use-after-free in poll trace queue dumps
      CVE-2026-74492: netfilter: ipset: do not update comments from kernel-=
side hash adds
      CVE-2026-74493: net/smc: fix socket use-after-free during link group =
termination
      CVE-2026-74495: igbvf: Fix leak in TX DMA error cleanup
      CVE-2026-74497: ALSA: usb-audio: Clamp frame size in implicit-feedbac=
k mode
      CVE-2026-74498: ALSA: usb-audio: Fix DMA buffer out-of-bounds write w=
hen fill_max is set
      CVE-2026-74499: ALSA: usb-audio: fix OOB write in snd_usbmidi_akai_ou=
tput()
      CVE-2026-74505: ALSA: 6fire: Fix UAF at error handling during probe
      CVE-2026-74507: Bluetooth: HIDP: validate numbered report payloads
      CVE-2026-74512: audit: fix potential use-after-free in audit_del_rule=
()
      CVE-2026-74518: mm/hugetlb: fix list corruption in allocate_file_regi=
on_entries()
      CVE-2026-74519: pinctrl: devicetree: don't free uninitialized dev_nam=
e on error path
      CVE-2026-74523: qede: sync udp_tunnel ports outside qede_lock in the =
recovery path
      CVE-2026-74525: net: sxgbe: free TX rings on RX allocation failure
      CVE-2026-74540: Bluetooth: L2CAP: fix UAF in l2cap_le_connect_rsp
      CVE-2026-74547: hwmon: (adt7470) Fix busy-loop and I2C flooding in up=
date thread
      CVE-2026-74548: forcedeth: fix UAF of txrx_stats in nv_remove
      CVE-2026-74549: hwmon: (nct6775-core) Prevent access to unsupported w=
eight registers
      CVE-2026-74556: scsi: libiscsi_tcp: Bound SCSI Response data segment =
to the connection buffer
      CVE-2026-74557: scsi: libiscsi: Fix stale-data leak into the SCSI sen=
se buffer
      CVE-2026-74563: rds: tcp: hold the RCU lock across ipv6_chk_addr() in=
 rds_tcp_laddr_check()
      CVE-2026-74564: netfilter: xt_hashlimit: validate hashtable supports =
XT_HASHLIMIT_RATE_MATCH
      CVE-2026-74566: keys: make keyring key-chunk byte order agree with ke=
yring_diff_objects()
      CVE-2026-74567: keys: fix out-of-bounds read in keyring_get_key_chunk=
()
      CVE-2026-74569: netfilter: nf_conntrack_sip: widen NAT rewrite delta =
to s32 in sip_help_tcp()
      CVE-2026-74577: net: mpls: initialize rtm_tos in mpls_getroute()
      CVE-2026-74579: netfilter: nft_payload: fix mask build for partial fi=
eld offload
      CVE-2026-74580: vhost: reset the vring metadata cache on vring reconf=
iguration
      CVE-2026-74581: net: ipv6: clear suppressed fib6 rule result
      CVE-2026-74583: net/sched: cls_route: fix fastmap use-after-free on f=
ilter
      CVE-2026-74585: thunderbolt: Bound the DROM dual link port number bef=
ore indexing sw->ports
      CVE-2026-74586: sctp: clear new_transport when removing a peer
      CVE-2026-74587: sctp: fix use-after-free of cached ASCONF chunk
      CVE-2026-74588: sctp: keep chunk->transport in step with the list it =
is queued on
      CVE-2026-74589: bpf, sockmap: Fix sk_redir use-after-free in send ver=
dict
      CVE-2026-74597: ip6_tunnel: clear skb2->cb[] in ip6ip6_err()
      CVE-2026-74598: ipv6: fix Route Information option length validation
      CVE-2026-74609: tipc: read le->link under the node lock in tipc_node_=
link_down()
      CVE-2026-74613: vsock/virtio: avoid refilling the RX queue after tear=
down
      CVE-2026-74615: vxlan: do not arm the ageing timer on a device that i=
s down
      CVE-2026-74622: net: atlantic: free RX pages of consumed but not refi=
lled buffers
      CVE-2026-74625: netfilter: bridge: release template ct on non-IP path
      CVE-2026-74630: ipv6: prevent in6_dev_get() from resurrecting inet6_d=
ev
      CVE-2026-74635: fbdev: bitblit: bound-check glyph index in bit_cursor=
()
      CVE-2026-74648: staging: rtl8723bs: validate monitor transmit frame l=
engths
      CVE-2026-74651: staging: rtl8723bs: fix OOB read in rtw_get_wpa_ie()
      CVE-2026-74654: serial: 8250_dma: Clear stale RX state on shutdown
      CVE-2026-74656: ipv4: fix use-after-free in fib_nhc_update_mtu()
      CVE-2026-74658: futex: Prevent robust futex exit race some more
      CVE-2026-74660: netfilter: ebt_nflog: pin the NFLOG backend
      CVE-2026-74664: net: openvswitch: reallocate update replies for misma=
tched IDs
      CVE-2026-74667: net/packet: reset the MAC header on the packet-socket=
 transmit path
      CVE-2026-74669: ipvs: clear IPv4 options after rebasing tunnel ICMP e=
rrors
      CVE-2026-74671: ima: fix out-of-bounds read in xattr_verify()
      CVE-2026-74673: Input: evdev - fix information leak in evdev_pass_val=
ues()
      CVE-2026-74675: vt: stabilize tty reference in kbd_keycode with tty_p=
ort_tty_get
      CVE-2026-74676: vt: add permission check for KDSKBMETA ioctl
      CVE-2026-74679: usb: gadget: f_ncm: Use unsigned int for ndp_index
      CVE-2026-74680: usb: atm: cxacru: properly kill rcv_urb on error in c=
xacru_cm()
      CVE-2026-74682: ALSA: usb-audio: fix OOB write on Type II inbound URB=
s
      CVE-2026-74683: Input: evdev - sanitize event type index when fetchin=
g event masks
      CVE-2026-74688: sctp: clear control chunk transport if it is being re=
moved
      CVE-2026-74693: net: prestera: validate firmware header length
      CVE-2026-74694: net/ncsi: fix heap OOB read in NCSI_CMD_SEND_CMD payl=
oad length
      CVE-2026-74697: bnxt_en: Disable EOP for TPA on all chips to prevent =
data corruption
      CVE-2026-74701: net/openvswitch: check Ethernet header length in key_=
extract()
      CVE-2026-74704: net/sched: sch_cake: drop WARN_ON(1) for malformed pa=
ckets in ACK filter
      CVE-2026-74705: udp: fix potential use-after-free in tunnel segmentat=
ion
      CVE-2026-74717: net/mlx5: fw_tracer, return NULL on create error
      CVE-2026-74719: net/smc: fix qentry overwrite for CONFIRM_LINK and AD=
D_LINK_CONT in smc_llc_event_handler()
      CVE-2026-74720: bpf: Preserve pointer state for commuted arithmetic
      CVE-2026-74726: bonding: alb: re-check primary_is_promisc under RTNL =
in bond_alb_monitor
      CVE-2026-74730: NFS: Pin the 'struct nfs_server' during a FREE_STATEI=
D call
      CVE-2026-80679: s390/dasd: Fix potential NULL pointer dereference
      CVE-2026-80680: i2c: amd-mp2: Unregister callback on adapter add fail=
ure
      CVE-2026-80681: vxlan: re-fetch eth header after route_shortcircuit()
      CVE-2026-80706: can: softing: fw_parse(): validate firmware record sp=
ans
      CVE-2026-80707: can: j1939: transport: j1939_session_fresh_new(): ini=
tialize receive buffer
      CVE-2026-80708: s390/zcrypt: Fix missing mem scrub at clear key impor=
t in cca_clr2cipherkey()
      CVE-2026-80714: ipvs: do not propagate one-packet flag to synced conn=
s
      CVE-2026-80716: ALSA: pcm: wake linked drain waiters on unlink
      CVE-2026-80717: sctp: validate Adaptation Indication parameter length
      CVE-2026-80718: mm/percpu-km: fix bitmap overflow and accounting in p=
cpu_create_chunk()
      CVE-2026-80731: net: remove CAP_SYS_RAWIO zero-padding in dev_validat=
e_header
      CVE-2026-80732: ata: pata_sl82c105: fix bridge revision use-after-fre=
e
      CVE-2026-80733: net: remove WARN_ON_ONCE() from sk_mc_loop()
      CVE-2026-80890: sctp: reject stale cookies with mismatched verificati=
on tags
      CVE-2026-80902: dmaengine: sun6i-dma: Fix reclaim descriptors while t=
erminating DMA
      CVE-2024-40973: media: mtk-vcodec: potential null pointer deference i=
n SCP
      CVE-2025-23160: media: mediatek: vcodec: Fix a resource leak related =
to the scp device in FW initialization
      CVE-2025-38524: rxrpc: Fix recv-recv race of completed call
      CVE-2025-40054: f2fs: fix UAF issue in f2fs_merge_page_bio()
      CVE-2026-31650: mmc: vub300: fix use-after-free on disconnect
      CVE-2026-64048: net/smc: reject CHID-0 ACCEPT that matches an empty i=
sm_dev slot
      CVE-2026-64192: bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BP=
F LSM is uninitialized
      CVE-2026-64269: RDMA/rtrs-srv: Bound RDMA-Write length to chunk size =
in rdma_write_sg
      CVE-2026-64270: Input: mms114 - reject an oversized device packet siz=
e
      CVE-2026-64280: fpga: dfl-afu: validate DMA mapping length in afu_dma=
_map_region()
      CVE-2026-64336: USB: serial: keyspan_pda: fix information leak
      CVE-2026-64583: usb: gadget: udc: bdc: free IRQ and drain func_wake_n=
otify before teardown
      CVE-2026-64586: wifi: brcmfmac: drain bus_reset work on device remova=
l
      CVE-2026-64590: dma-buf/udmabuf: skip redundant cpu sync to fix cache=
line EEXIST warning
      CVE-2026-68082: libceph: fix two unsafe bare decodes in decode_locker=
s()
      CVE-2026-68096: audit: fix recursive locking deadlock in audit_dupe_e=
xe()
      CVE-2026-68132: super: fix emergency thaw deadlock on frozen block de=
vices
      CVE-2026-68136: net: gro: fix double aggregation of flush-marked skbs
      CVE-2026-68138: net/sched: serialize qdisc_rtab_list against concurre=
nt get/put
      CVE-2026-68146: ftrace: Add global mutex to serialize trace_parser ac=
cess
      CVE-2026-68159: libceph: bound pg_{temp,upmap,upmap_items} length to =
CEPH_PG_MAX_SIZE
      CVE-2026-68162: sctp: avoid auth_enable sysctl UAF during netns teard=
own
      CVE-2026-68198: wifi: ath6kl: fix use-after-free in aggr_reset_state(=
)
      CVE-2026-68202: ALSA: seq: close a re-opened queue timer in the destr=
uctor
      CVE-2026-68205: media: v4l2-fwnode: Fix subdev owner overwritten in v=
4l2_async_register_subdev_sensor()
      CVE-2026-68255: drm/virtio: bound EDID block reads to the response bu=
ffer
      CVE-2026-68277: drm/dp/mst: fix OOB reads on 2-byte fields in sideban=
d reply parsers
      CVE-2026-68278: drm/dp/mst: fix buffer overflows in sideband chunk ac=
cumulation
      CVE-2026-68279: drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband=
 reply parsers
      CVE-2026-68367: usb: gadget: f_tcm: synchronize delayed set_alt with =
teardown
      CVE-2026-68434: serial: 8250_mid: Fix NULL function pointer dereferen=
ce on DNV/ICX-D/SNR platforms
      CVE-2026-72015: fs/resctrl: Fix double-add of pseudo-locked region's =
RMID to free list
      CVE-2026-72023: octeontx2-pf: fix SQB pointer leak on init failure
      CVE-2026-72035: net/sched: sch_taprio: Replace direct dequeue call wi=
th peek and qdisc_dequeue_peeked
      CVE-2026-72041: espintcp: use sk_msg_free_partial to fix partial send
      CVE-2026-72051: net: ip6_tunnel: require CAP_NET_ADMIN in the device =
netns for changelink
      CVE-2026-72053: net: ipip: require CAP_NET_ADMIN in the device netns =
for changelink
      CVE-2026-72063: gpio: tegra: do not call pinctrl for GPIO direction
      CVE-2026-72070: wifi: libertas_tf: fix use-after-free in lbtf_free_ad=
apter()
      CVE-2026-72073: mmc: vub300: fix use-after-free on probe failure
      CVE-2026-72075: Input: ims-pcu - fix race condition in reset_device s=
ysfs callback
      CVE-2026-72077: Input: ims-pcu - fix firmware leak in async update
      CVE-2026-72084: scsi: target: Bound PR-OUT TransportID parsing to the=
 received buffer
      CVE-2026-72087: scsi: lpfc: Fix memory leak in lpfc_sli4_driver_resou=
rce_setup()
      CVE-2026-72096: dm-verity: make error counter atomic
      CVE-2026-72099: dm-integrity: don't increment hash_offset twice
      CVE-2026-72142: i2c: imx: fix locked bus on SMBus block-read of 0 (at=
omic)
      CVE-2026-72148: dmaengine: dw-edma: Add spinlock to protect DONE_INT_=
MASK and ABORT_INT_MASK
      CVE-2026-72152: tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_st=
at()
      CVE-2026-72155: mtd: spi-nor: swp: Improve locking user experience
      CVE-2026-72157: net: thunderbolt: Fix frags[] overflow by bounding fr=
ame_count
      CVE-2026-72166: net/9p: fix infinite loop in p9_client_rpc on fatal s=
ignal
      CVE-2026-72168: mtd: maps: vmu-flash: fix fault in unaligned fixup
      CVE-2026-72170: 9p: skip nlink update in cacheless mode to fix WARN_O=
N
      CVE-2026-72225: jbd2: fix integer underflow in jbd2_journal_initializ=
e_fast_commit()
      CVE-2026-72242: selinux: avoid sk_socket dereference in selinux_sctp_=
bind_connect()
      CVE-2026-72253: netfilter: nf_conntrack_sip: validate skb_dst() befor=
e accessing it
      CVE-2026-72299: tipc: restrict socket queue dumps in enqueue tracepoi=
nts
      CVE-2026-72308: mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()
      CVE-2026-74436: rxrpc: serialize kernel accept preallocation with soc=
ket teardown
      CVE-2026-74470: scsi: scsi_debug: Fix REPORT ZONES alloc_len underflo=
w OOB write
      CVE-2026-74479: net: pktgen: fix proc entry use-after-free
      CVE-2026-74486: binfmt_misc: use exe_file_deny_write_access() for the=
 interpreter clone
      CVE-2026-74487: binfmt_misc: restore write access when removing an en=
try
      CVE-2026-74508: Bluetooth: HIDP: reject frames without a transaction =
header
      CVE-2026-74575: thunderbolt: Prevent XDomain delayed work use-after-f=
ree on disconnect
      CVE-2026-74594: sched/psi: Shut down rtpoll_timer in psi_cgroup_free(=
)
      CVE-2026-74599: mm/ptdump: always stabilise against page table freein=
g using init_mm
      CVE-2026-74601: ring-buffer: Use current_context for safe per-CPU buf=
fer swap
      CVE-2026-74620: net/sched: act_gact, act_police: range check the fall=
back control action
      CVE-2026-74623: net: atlantic: free stranded TX buffers on ring deini=
t
      CVE-2026-74631: net: smc: fix splice entry lifetime imbalance in smc_=
rx_splice
      CVE-2026-74641: ALSA: usx2y: bound the hwdep mmap fault offset
      CVE-2026-74737: net: ethernet: ti: am65-cpsw-nuss: Fix port_id extrac=
tion from SRC TAG
      CVE-2026-74746: netfilter: flowtable: publish GC-visible tuple last
      CVE-2026-74748: netfilter: ipset: fix refcount race between list:set =
GC and swap
      CVE-2026-80527: ceph: fix hanging __ceph_get_caps() with stale mds_wa=
nted
      CVE-2026-80528: ceph: avoid fs reclaim while using current->journal_i=
nfo
      CVE-2026-80540: drm/amdgpu: Fix UVD decode image min size calculation
      CVE-2026-80541: drm/amdgpu: validate GEM_CREATE domain combinations
      CVE-2026-80550: s390/vfio_ccw: Fix out of bounds check on CCW array
      CVE-2026-80558: libceph: Avoid using invalid osd indices from primary=
_temp
      CVE-2026-80559: Input: sur40 - fix input device registration ordering
      CVE-2026-80560: openrisc: signal: do not restore privileged SR bits o=
n sigreturn
      CVE-2026-80561: libceph: fix multiple unsafe decodes in decode_locker=
()
      CVE-2026-80565: crypto: qce - fix error path in devm_qce_register_alg=
s
      CVE-2026-80567: Input: synaptics-rmi4 - propagate F54 worker errors t=
o V4L2 queue
      CVE-2026-80568: Input: synaptics-rmi4 - block s_input when F54 queue =
is busy
      CVE-2026-80569: Input: synaptics-rmi4 - bound the F54 report size to =
the allocated buffer
      CVE-2026-80570: Input: synaptics-rmi4 - zero report size on F54 work =
error
      CVE-2026-80573: Input: iforce - validate input packet lengths
      CVE-2026-80574: Input: focaltech - fix array out-of-bounds in focalte=
ch_process_rel_packet
      CVE-2026-80584: s390/qeth: validate user buffer length in SNMP and AR=
P query ioctls
      CVE-2026-80586: mptcp: options: reset DSS fields in case of unexpecte=
d size
      CVE-2026-80742: af_packet: Don't send zero-byte data in tpacket_snd()=
.
      CVE-2026-80743: ASoC: xilinx: formatter_pcm: pass aud_drv_data to irq=
 handlers
      CVE-2026-80744: netfilter: nf_tables_offload: suppress WARN_ON_ONCE f=
or ENOMEM in abort path
      CVE-2026-80752: Input: psxpad-spi - set driver data before use
      CVE-2026-80754: Input: synaptics-rmi4 - fix F55 transmitter electrode=
 count typo
      CVE-2026-80756: selinux: do not cancel a policy conversion that never=
 started
      CVE-2026-80757: selinux: reject a class permission count below its in=
herited common
      CVE-2026-80906: net: packet: fix wrong transport_header when sending =
VLAN-tagged frame
      CVE-2026-80908: drm/amdgpu: Reject UVD message with dimensions above =
4096
      CVE-2026-80909: drm/amdgpu: Reject UVD message with invalid number of=
 h265 refs
      CVE-2026-80913: selinux: require every boolean value to be defined
      CVE-2025-68794: iomap: adjust read range correctly for non-block-alig=
ned positions
      CVE-2026-45839: bpf: reject negative CO-RE accessor indices in bpf_co=
re_parse_spec()
      CVE-2026-64581: xfrm: fix sk_dst_cache double-free in xfrm_user_polic=
y()
      CVE-2026-74582: packet: use consistent hard_header_len in non-ring se=
nd paths
      CVE-2026-74626: NTB: ntb_netdev: Preserve RX queue depth on allocatio=
n failure
      CVE-2026-74628: net/x25: fix use-after-free of the socket by its time=
rs
      CVE-2026-74632: mm/huge_memory: fix huge_zero_pfn race
      CVE-2026-74637: perf/core: Fix group leader use-after-free after sibl=
ing detach
      CVE-2026-74647: misc: fastrpc: Remove buffer from list prior to unmap=
 operation
      CVE-2026-74650: staging: rtl8723bs: fix OOB read in WMM_param_handler=
()
      CVE-2026-74657: ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops
      CVE-2026-74662: inet: frags: publish queues before arming timer
      CVE-2026-74663: net/sched: reject overly deep qdisc hierarchies
      CVE-2026-74666: packet: synchronize pressure clearing with ring recon=
figuration
      CVE-2026-74668: packet: use consistent hard_header_len in TX_RING sen=
d path
      CVE-2026-80534: xfs: fix ilock leak on error in xfs_dq_get_next_id
      CVE-2026-80536: xfs: bounds-check buffer log item's dirty bitmap
      CVE-2026-80553: s390/vfio_ccw: Cancel existing workqueues
      CVE-2026-80555: s390/vfio_ccw: Free all memory if cp_init() fails
      CVE-2026-80557: libceph: fix OOB read in decode_watchers() via missin=
g bounds check
      CVE-2026-80562: gpio: ml-ioh: use raw_spinlock_t for the register loc=
k
      CVE-2026-80737: serial: amba-pl011: synchronize DMA teardown
      CVE-2026-80765: HID: hyperv: validate initial device info bounds
      CVE-2026-80767: HID: sensor: custom: Fix use-after-free in enable_sen=
sor
      CVE-2026-80781: HID: core: fix OOB read of field->usage in hid_set_fi=
eld()
      CVE-2026-80788: nvmet-tcp: Do not WARN on remotely-controlled oversiz=
ed SGL allocations
      CVE-2026-80790: nvmet-fc: fix invalid free in LS IOD error path
      CVE-2026-80792: ipv6: fix use-after-free in ip6_finish_output2()
      CVE-2026-80793: ipv4: reject undersized MTUs in ip_do_fragment()
      CVE-2026-80795: nfc: nci: fix out-of-bounds write in nci_target_auto_=
activated()
      CVE-2026-80797: nfc: pn533: purge fragmented skbs during cleanup
      CVE-2026-80798: nfc: llcp: reject PDUs shorter than the LLCP header
      CVE-2026-80799: nfc: llcp: fix OOB read and u8 offset wrap in TLV par=
sers
      CVE-2026-80800: nfc: llcp: bound the connect_sn TLV walk to the skb
      CVE-2026-80801: nfc: microread: validate target discovery payload len=
gths
      CVE-2026-80802: nfc: fdp: bound the device-reported read length and f=
ix an skb leak
      CVE-2026-80803: nfc: digital: clamp SENSF_RES length to the destinati=
on buffer
      CVE-2026-80805: xfs: validate attr entry pointer before field access
      CVE-2026-80808: ext4: stop retrying saturated xattr cache entries
      CVE-2026-80809: ocfs2: fix missing metadata reservation for large xat=
trs
      CVE-2026-80814: rndis_host: add overflow check in rndis_rx_fixup()
      CVE-2026-80819: Bluetooth: RFCOMM: take rfcomm_mutex for the deferred=
 setup accept
      CVE-2026-80823: nfc: st21nfca: validate ATR_REQ length against the re=
ceived frame
      CVE-2026-80889: can: isotp: fix timer drain order, wakeup handling an=
d tx_gen ordering
      CVE-2026-80918: HID: core: fix number/pointer type confusion on long =
items
      CVE-2026-80590: inet: frags: strip GSO state from fragments before re=
assembly
    added commits:
      CIP: Bump version suffix to -cip77 after merge from stable
      of: Reimplement of_machine_is_compatible() using of_machine_compatibl=
e_match()
      of: Change of_machine_is_compatible() to return bool

Best regards,
  Nobuhiro


