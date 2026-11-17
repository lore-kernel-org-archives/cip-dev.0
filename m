Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8464.1794878070172440164
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Nov 2026 17:14:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=Z2z7Y8xO;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794878059;x=1796087659;bh=
	3LFyOzMCaItPQiDEKKecKhRTzqpqdi6356RPKWi7G6g=;b=Z2z7Y8xOUn938bd/ox2pujGjTdNvUr
	qXKgqCUDNvGYWrmJqXjQgCD+V4hcyzNZrZxCUpn6g/V+aQBUlVYGXx+DPLa8ChudwqiRsIgF6MUMO
	XFbxJeFB2C0gCfmcQnHuF5eMOpx2AllVuVk6JJtq4DqNZPQlqRRDn3a7TRv7Qp98xYLLpQDP7TEpM
	PxO19QwqGJwWXLiIcNohgFVPzNpf3jOqjfGNNpMXHYZ6WPJh8PR9dN+LwyPLMkiMjJGpp66gcNmHX
	2LWG73yHR2qm3X9d1cLTyn30b6XrDu+Hm7nnCMJYG+LEMr0qbUOtL0XjjHIp11GGKK1BU//j1vQB3
	FWNA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6AH1EIC41033414; Tue, 17 Nov 2026 10:14:18 +0900
X-Iguazu-Qid: 2yAbSJ9nt44q2Mp4QV
X-Iguazu-QSIG: v=2; s=1; t=1794878057; q=2yAbSJ9nt44q2Mp4QV; m=NIk3Y46XVzV3LSVUfsULmE+7hm1zmyvlzOo+gPW7FCQ=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jT6Fg6pp0z1xnZ; Tue, 17 Nov 2026 10:14:14 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmAFUsU0Nl71+xtMpdK/QA1cwJWJKpmEMObNZhcQ4r+1hkiFRsMSVWbDzVGWwBevAxV9v7dbSaYPWmv1b1wJoaPj7dHIAEaA0Z8zfgYmU/RzNzV+KSinHZdMfTAsYqfEkXVqDdawxUk4Zpc9+zlcGetycKAsLZiG7B/+/aMd0+LN3EQWDnDd60Rgzl7jRomyWGNATFAp6V4KVNbFE9f7USpy8oetDc1iohbjUJIsOJHuM4clqdKZYnVKZwFzu+yGot+X0Ofta1OFKs9xGxU0TllpuMKUVgnLn3KId1xqNgUjliyjH8ptjSNKcSumElMoHwlJ8q7Vg3vmD5Mfy4e3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McH8eoyTpR++EuAl1+uluscKx/RCIh/iP3T2fuc1WVY=;
 b=O21um00wy66N7711sPMX0OC8P124mbQqZHDhMbINM0MizG9trkCejimLjEPzbDcDnjf+Wtm5LWuZ9xPc6wkNAuj7ijcALuIMtK7MJdUS9rhZWTj6dP95I5jn6G77M/L1Gc0gnXTpQd8fnrhYbgmKLfOYLOFhjh7R4LDLvkBdq/PCW4VMf9E0Dv0yYaSFiIVcHqpr+7h4oTjXMmH0jIWxl3InZ2Y3+euH38k3uiDy0t8pFpgfBFqyHYw3thz4HL0j+qt0WdZ5caBoZLC47e9vEeG39b/SeduBXOl3Yr3LYGUsdiBsxmm6y+AB1fURhwWQB126IVXSCj5KWlwCYswQ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <masami.ichikawa@miraclelinux.com>,
        <uli@fpond.eu>, <pavel@nabladev.com>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.12.117-cip35
Thread-Topic: [ANNOUNCE] Release v6.12.117-cip35
Thread-Index: Ad12MN9xBvugLGz1RU6DvZe8snJ+lg==
Date: Tue, 17 Nov 2026 01:14:09 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB14818E0CB4EA9A3E19AFBF7E6CD7B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB8864:EE_
x-ms-office365-filtering-correlation-id: bf809df2-94b3-4b01-b7f1-08df4448159b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|6133799003|261009223027099003|3023799007|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261021135927099003|38070700021|10067099003;
x-microsoft-antispam-message-info: NFziByGQpT31N0mQFEhoCilfKSDL2y8rvvVOyvbA+6tWQwOGYi5l329KqiSI2u6DYvxPiq4wrMZ2l6ceuWp5NBVu1IF4CFrIZDGpr1KjuvF7evt+qbHgxmuAJ0pkUOrPuSUz9heRhf/xbUe/uB0HxotnjwPKMjn6bwj/iV1ngttsCR6uR0nRSGhEv8jzujdo4dHBH5TW0W7lrfeivQAiBfyo35Bh2RNEzmr86vXuWGWwzMTRaeemue+UzVAE/Lb2A1fV0dI3Zvj0hSsh6m7KMahu4+RDKEcSG4tJxhKypcHU0MMMOWcBF0gHNHRMIkCOFHs+tOYTjPwDaGmAGzwuV1P5hy08N63O6zEqelIrV8eycXJpB3f/tpv5IgYwT4JHBPbADM70uZr3aBBVDDKF5NBHuZpoIKEphZMU4jxGeXRKH41bWuug/g7QTxI0RV2Nr5lj0AM1uCSmx2SubjyzzOFl4YwpaYw4Or/PXQJPDmiiOJOBjCkKkjeiWVbuhlHeERwcmOzYFGwh7b4VQTmeaFgeO1YwVVzy7na0TDbUWp55sQj5cUREWExryt5J3VbA3ccwk9T77BMktKS1pbpUHUjOeFsD3tFyE0u7EgX+RlzWm0qazkrB1gIpXS+BtAM5N+uaKCMoTHH7kLfeXaTVgETxsXGwBXxbr8vZZHnqAtg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(6133799003)(261009223027099003)(3023799007)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021135927099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UUlwNE9WUnJNaVJoeGhOYnBKb1hlTkNPUnkzN1ZjTUNRTHNlQS9mblpG?=
 =?iso-2022-jp?B?TFpZakdUNVlsSTZoNnRSYVRTNE92YmtPOUFWRkdaMldKYmErcy9mNmp1?=
 =?iso-2022-jp?B?V1R6TnhlVDZEN0hwdktNbnNrV1M4OFZ6UkZQSk4vQVFidVdpSkZzcWkr?=
 =?iso-2022-jp?B?ejkzQkdJcnJxcnpvazczaVMvTDJMM0ozZG1wbzh6Q3JsUVp4RlRndU5k?=
 =?iso-2022-jp?B?QnNnRWdWYW1uTDVJWEZTSzF2MkpQTWxVSVc2aXlyNHdIUk5hcCtTK1VT?=
 =?iso-2022-jp?B?ODFVelczZVpMeEVPaXU2Y3BXZXh4S3RsZkk2bzBqMi9UUi8xNVF2ZnBO?=
 =?iso-2022-jp?B?Y1NWenNBNEZIVWV2bFo5b2lhRHVrd0NsU204dEJHMVBGZ1d4dTNWdWFF?=
 =?iso-2022-jp?B?UjJyaXdPWU4wa1lMNEpMc3ZScEFHQUFuazl1VkthOVN0alFzSFVIWFhx?=
 =?iso-2022-jp?B?OW5hSnQ2ZFYxTFpleGpCNkEzUXkzTnJwcldneFlia1NLVDZvcWpOVFdr?=
 =?iso-2022-jp?B?UUdOK0FBSmIrN1BIUWJRblJTUzJxSHFrUXNiaWZReHBWb0ZMckE4TVVU?=
 =?iso-2022-jp?B?MWlVMWpSWk1pYVhPMnh2MlVkMU9rNlpEbHJibE0vdkpyUnhLOFdROFdD?=
 =?iso-2022-jp?B?T0VzK1VEZEo3VmtvMFJjTTQ1U3pHRFA5YUtsQkdzMVFCdmQwTGFGSkFN?=
 =?iso-2022-jp?B?UzlvOHlZdWpTSVNOdVNFNFJBMjdaeElQWTRVREw5OGNvMnFxL29Ud3hG?=
 =?iso-2022-jp?B?cm4zU0dVYmtxT2xPQkRYVjRxR0JOaVhsTFdtR2pYUisyK0lpMHY3U1B5?=
 =?iso-2022-jp?B?WFBUSGdpSlF0cWVaOUJ2RngzMFdXdDdUeEdXenkxRlRpZFcxcmJzMFFV?=
 =?iso-2022-jp?B?V0s3VXdwMlhQTllqZlZDOFJLWU1sZHBnR1Flc1dZZ2k1TG1mMXJEVmNm?=
 =?iso-2022-jp?B?akFQeURrWDhzQm82UmRnbldyc1o3VEFKejA4bjJuNWFPanhuLzVqNUM1?=
 =?iso-2022-jp?B?S1V2eU1hMGZvN2svRjZqdzNFdkp1VVMxNTBKZ3Z1Tk1lQ0wyV1JFQUNu?=
 =?iso-2022-jp?B?K0NOVnUzMVlRSnJjajZ1TUkwa1JhSWd1WHRXdGxQc0pJWHhiYjBNd0Zo?=
 =?iso-2022-jp?B?ZXJGc2RJU05GL0Z5NllwMXJoVE5aVm9LcjYrcHljbGxzMEFUYldML3Uy?=
 =?iso-2022-jp?B?aXFYK3pZMGNocnY3dDRJYjlNMitnbUtsVGJwTlI2d3Q3dVVRZHd1blI2?=
 =?iso-2022-jp?B?bEpBb3hKbGV0UHFKSmp1czViLzJXY1IzcXpFMmxKd1ZkRkNpRUxIM284?=
 =?iso-2022-jp?B?d29scG1uYVpXZEpOdXcrR2Z6Y1hnNVNvcTErME1zaUlGUDRjbE8wUVJ0?=
 =?iso-2022-jp?B?eVd3eVBSMlhzREdOd2EvUVRDTDk0WExvaWZCeG5SOEZ6UzV2Nm9ObWJB?=
 =?iso-2022-jp?B?Vjk1M1JHNUZQTEg4L0E2ZGo3eklQOWlqVzlUM0xlWFc5TFJuRDdWbzNL?=
 =?iso-2022-jp?B?YXpaZVpJLzFPUldRMkJtRDNkdnZnejhjYzZLY242MFVNTGl3VkZKZmx2?=
 =?iso-2022-jp?B?L0xwYmVJNURCZVRrdm1zV08zVzFkY01XYjQ3OEFRTmRHUUN5TXZ1K0s0?=
 =?iso-2022-jp?B?SGhweU80UTFXTXZ2cm54cFhabTlOYlg2MS93RmRsZXpTdEk4bE9xTGhx?=
 =?iso-2022-jp?B?SzcxanVENnNmMjkzV3V2bUNscThzZzBRSnB1VENGbVY2a2tLUlRMSGZL?=
 =?iso-2022-jp?B?ZCszMGgrOVRNcFBwWE54aGN4bllFQU9MSFNia1lmQXNxOFBjZHJsM2Fu?=
 =?iso-2022-jp?B?WGk5M2l4WXhuNFg3SUlaN0JWSGVOUjU4VmUwLzY2bGUyKzA0V1BpUG8w?=
 =?iso-2022-jp?B?TUFjY3BZK3lHZGdjZUR3VmV5VHBrS0IzUXE3U0tHSGVmTUlUQldGTm1V?=
 =?iso-2022-jp?B?KzBNck5NWlBhMDl3ckZlTTJqQU5icTk4Uk1zV1o2Rld5TkRRaFRNMTdO?=
 =?iso-2022-jp?B?NHVuZUNkUVBOcTFRbmxHM0tEeTExbXFIV1JQNnpnK2JmMHlJTGorMkdw?=
 =?iso-2022-jp?B?U1JYbGZ1MFJ1cXcvRjgvMEp5UENmdXNVZVJ2RzkrelNGdWRpYUZScGMw?=
 =?iso-2022-jp?B?bnRTWjZHMVNJQUNHMlNiWnhrTVdEVHZtUWNSR1NxSENuQVpud1BvWGNL?=
 =?iso-2022-jp?B?YkdHeW5LZmlIWXkyRDRzS2tQeW43VStHVS9TSCt4SmorbGc2UEt4WUln?=
 =?iso-2022-jp?B?cGZ4MmNIdE4wcDQ3Q0EvOGZodFdnWW5PNzlyTzR5MURsSzlEVUZzd1ZI?=
 =?iso-2022-jp?B?Y1NCZEx2T1NRZnpVaFJxeFI0Vm9tSDFxWjA1LzZucWlKSlNNN1F3YTlx?=
 =?iso-2022-jp?B?S3AvQ1B1dG91N0dZU1UvVGVMcWprTEJhTVRnSGYwWGd6MC84S1lzaGpU?=
 =?iso-2022-jp?B?T3ZndHJrS2d5VXQzZmRseHVIMms2Mzd3ejZnZ1JuV2tSSFU3c3ZpQjY2?=
 =?iso-2022-jp?B?QVFOL0F1Smg4cnp1Ynl2NldJYTAwbWZMcTVKM3ZSRFUzakRyaHNxdDc5?=
 =?iso-2022-jp?B?T0ZNNkdSYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gSrhxhIcdf6Qwi/jwlJFgbjxPPd4UeMOk4lgdfPXdV6JJiDV4tZ1kgrTkMOJG5j62D7eoeaJFNgKzXNsspXcz8gftVwYVZEEbJKgTQKJfp6wClSh9apgqj8yG4S40OSR1LGVcsMirc71wpEjhkHj18b25mLw9No3taUPbAkdO7GB1ry90bKs68q4FLsbwd88bGFzsqhmDUSYzMXknnKGmOOeICTWjdYfIR4D/aZuB4j/sCuCGq8o28QIoHugljcgbtunJdUsGCmDVAiAWHBd9N6EE26o/sXVHv8xxOCF3DJHsUxNsbMKaQq+Ix/6PSvGx9eJ29l/IK6UrorovrsYKQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf809df2-94b3-4b01-b7f1-08df4448159b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 01:14:10.0268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: co8eVD/oiFyVwldL9NvEb0YWTUOozmp4rKx+MEmBKVp+62geoC1YOrxLDccYiXL9Jfor55pw72IPuxIeJUTukLGGNkfNDaFrQP20tmCPDAJXRYnTUKxKrws/t2kwBt7w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8864
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 01:14:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24810

Hi all,

CIP kernel team has released Linux kernel v6.12.117-cip35.
The linux-6.12.y-cip tree has been updated base version from v6.12.114 to v=
6.12.117.

Additionally, patches have been added in this release to support RTC, displ=
ay output
(LCDC/DU), and PCIe, as well as to optimize the XSPI/RPC-IF drivers for Ren=
esas ARM64
SoCs (RZ/T2H, RZ/N2H, and RZ/V2H). It also includes patches to improve VFP =
locking in
order to enable PREEMPT_RT support on the ARM architecture.

Information about this release is as follows:

  v6.12.117-cip35:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      a7db02f4a542344fbaef08cc445aefbb348912ef
    fixed CVEs:
      CVE-2026-72453: regcache: Do not overwrite error code when finalizing=
 cache after error
      CVE-2026-80729: mm/huge_memory: initialise workingset state before fo=
lio split
      CVE-2026-89754: mm/pagewalk: fix stale walk->action escaping walk_pmd=
_range()
      CVE-2026-99077: ipv4: udp: Create exceptions before socket matching
      CVE-2026-99100: wifi: p54: validate firmware record lengths
      CVE-2026-99103: workqueue: Fix unbound pool lifetime for pending pwqs
      CVE-2026-99105: sched_ext: Fix stall when a task enqueued with SCX_EN=
Q_LAST lands back on its CPU's local DSQ
      CVE-2026-99106: drm/amdgpu: free the userptr ranges when a CS fails a=
fter parser_bos
      CVE-2026-99110: smb: client: fix heap overflow in cifs_do_set_acl()
      CVE-2026-99112: net/sched: cls_flower: validate mask pointer after nl=
a_next()
      CVE-2026-99113: ksmbd: zero the FS_OBJECT_ID_INFORMATION buffer befor=
e filling it in
      CVE-2026-99114: ksmbd: initialize FileSystemControlFlags in FS_CONTRO=
L_INFORMATION
      CVE-2026-99115: ksmbd: fill in FileSysIdentifier in FS_POSIX_INFORMAT=
ION
      CVE-2026-99117: net: bridge: mcast: don't truncate the port group wal=
k on teardown
      CVE-2026-99118: drm/i915/dmc: Harden DMC firmware payload parsing
      CVE-2026-99121: ipv4: avoid divide by zero in fib_rebalance
      CVE-2026-99123: vsock/virtio: validate packet source for connected so=
ckets
      CVE-2026-99124: s390/pci: Fix leak of uninitialized kernel data in SC=
LP report
      CVE-2026-99126: s390/ctcm: Prevent XID null dereference
      CVE-2026-99127: page_pool: keep frag_offset aligned for odd-sized req=
uests
      CVE-2026-99128: sctp: validate chunk length in the inqueue parser
      CVE-2026-99130: io_uring/cancel: don't spin on local work the task ca=
n't run
      CVE-2026-99131: xfs: fix capability check in xfs
      CVE-2026-99132: xfs: don't hold buffer locks across sync transaction =
commit in xfs_sync_sb_buf
      CVE-2026-99133: net/iucv: fix the recvmsg window update
      CVE-2026-99134: mac802154: fix data race and NULL deref on local->ass=
oc_dev
      CVE-2026-99135: dm-integrity: fix infinite loop on discard with large=
 tag size
      CVE-2026-99136: dm-crypt: fix a tiny race condition in crypt_dec_pend=
ing
      CVE-2026-99138: tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_I=
NFO)
      CVE-2026-99139: tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONG=
ESTION)
      CVE-2026-99140: tracing: Fix hist trigger timestamps for buffered eve=
nts
      CVE-2026-99142: tracing: Check operator stack capacity before pushing
      CVE-2026-99143: tracing: Keep the predicate limit separate from progr=
am capacity
      CVE-2026-99147: drm/exec: don't immediately add prelocked obj to arra=
y of locked objs
      CVE-2026-99150: drm/amdgpu: don't drop the runtime PM reference twice=
 in amdgpu_gpr
      CVE-2026-99152: scsi: libiscsi: Validate the task named by a manageme=
nt response
      CVE-2026-99153: scsi: libiscsi: Validate the ITT reflected in a Rejec=
t PDU
      CVE-2026-99154: scsi: libiscsi: Reject a negative task index from par=
se_pdu_itt
      CVE-2026-99155: scsi: xen/scsifront: Check for a NULL shadow entry on=
 a backend response
      CVE-2026-99156: scsi: st: Fix use-after-free race between st_remove()=
 and st_open()
      CVE-2026-99157: scsi: bsg: Pass reply_len to bsg_setup_queue() to fit=
 UFS ARPMB replies
      CVE-2026-99158: ring-buffer: Fix false warning in ring_buffer_map_get=
_reader()
      CVE-2026-99159: ring-buffer: Fix the sub-buffer array base in rb_meta=
_subbuf_idx()
      CVE-2026-99160: ring-buffer: Do not show buffer_meta for CPUs without=
 a buffer
      CVE-2026-99161: i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()
      CVE-2026-99163: tracing/histograms: Reject non-stacktrace fields for =
synthetic stacktrace fields
      CVE-2026-99165: sctp: revalidate output stream after association conn=
ect wait
      CVE-2026-99166: net: rds: fix uninitialized trans dereference in CM e=
vent handler
      CVE-2026-99167: net/sched: fix use-after-free in __tcf_action_put()
      CVE-2026-99169: futex: Fix mm reuse handling for FUT_OFF_MMSHARED
      CVE-2026-99171: ntfs3: free the sbi after a grace period
      CVE-2026-99173: eventfs: Free the eventfs_inode after an rcu grace pe=
riod too
      CVE-2026-99174: ext4: free the sbi after a grace period
      CVE-2026-99175: fsnotify: prevent mark additions during connector tea=
rdown
      CVE-2026-99176: KVM: nVMX: Reset MMU back to the root MMU if loading =
L2 state fails for !VM-Entry
      CVE-2026-99178: x86/kvm: Don't consume async #PF flags on a kernel #P=
F in NMI context
      CVE-2026-99179: watch_queue: Fix note pool publication race in watch_=
queue_set_size()
      CVE-2026-99180: unicode: free the map after a grace period
      CVE-2026-99181: autofs: ignore notification errors from a replaced pi=
pe
      CVE-2026-99182: ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for=
 aggregated ALH capture
      CVE-2026-99187: perf: Fix perf_pmu_migrate_context() leaving events b=
ehind
      CVE-2026-99190: gpiolib: fix memory leak in gpiod_set_array_value_com=
plex() on error paths
      CVE-2026-99191: calipso: keep BIG TCP payload_len in calipso_skbuff_s=
etattr()
      CVE-2026-99192: net: bcmgenet: unshare the skb before writing the con=
trol block
      CVE-2026-99201: netlink: avoid hashing the network namespace pointer
      CVE-2026-99202: scsi: libsas: Fix SMP IO deadlock during HA resume
      CVE-2026-99203: pipe: preserve existing fasync readers on writer setu=
p failure
      CVE-2026-99204: ocfs2/dlm: Protect the recovery list during debugfs r=
eads
      CVE-2026-99206: scsi: target: iscsi: Fix race in discovery auth updat=
es
      CVE-2026-99211: netlink: reset skb headers before unicast and multica=
st filtering
      CVE-2026-99212: net/rds: don't let the rdma_cm destroy an id RDS stil=
l owns on route failure
      CVE-2026-99213: vsock: treat TCP_CLOSING as once-established
      CVE-2026-99214: drm/vc4: hdmi: Move packet RAM enable to PM runtime
      CVE-2026-99216: Drivers: hv: Don't reset VMBus connection state on er=
ror/exit paths
      CVE-2026-99217: [REJECTED]: fork: release the files of a failed fork =
after sched_cancel_fork()
      CVE-2026-99218: coredump: hold RCU while releasing parked threads
      CVE-2026-99219: ftrace: Initialize modname and offset in print_rec()
      CVE-2026-99220: asymmetric_keys: reject trust keys without IDs
      CVE-2026-99221: keys/trusted_keys: return immediately after TPM unsea=
l failure
      CVE-2026-99222: keys: Protect the read method check against type remo=
val
      CVE-2026-99223: keys: make keyring indexes independent of kernel addr=
esses
      CVE-2026-99224: keys: Protect the type name while describing a key
      CVE-2026-99225: keys: Check the authorization payload in process keyr=
ing searches
      CVE-2026-99226: keys: Avoid the owner account dereference in named ke=
yring lookup
      CVE-2026-99227: io_uring/waitid: prevent cancel reference wrap
      CVE-2026-99228: io_uring/io-wq: don't lose the signal that ends work
      CVE-2026-99229: io_uring/wait: don't spin on a stuck overflow list
      CVE-2026-99230: io_uring/cmd: don't leave list poison in ->hash_node
      CVE-2026-99231: io_uring/waitid: own the request before clearing ->he=
ad
      CVE-2026-99233: tracing/histograms: Verify event_call identity when u=
pdating synth_event refcount
      CVE-2026-99234: tracing: Unregister field variable histograms when th=
e command fails
      CVE-2026-99235: tracing: Save the event file instead of the compatibl=
e histogram
      CVE-2026-99236: tracing: Reject incomplete event filter expressions
      CVE-2026-99239: Bluetooth: L2CAP: refuse __l2cap_chan_add if chan alr=
eady has conn
      CVE-2026-99243: [REJECTED]: io-wq: order the exit bit against worker =
creation task work
      CVE-2026-99244: pid_namespace: prevent TIF_NOTIFY_SIGNAL from interru=
pting the reaper
      CVE-2026-99245: KEYS: Fix key_reject_and_link() race with keyring res=
triction
      CVE-2026-99246: tipc: protect node reset trace dump with node lock
      CVE-2026-99247: tracing: Do not initialize tracefs work if tracing is=
 disabled
      CVE-2026-99249: pid_namespace: make zap_pid_ns_processes() freezable
      CVE-2026-99250: printk: Postpone kthread startup
      CVE-2026-99251: Drivers: hv: Avoid infinite retry loop in init_vp_ind=
ex()
      CVE-2026-99254: io_uring: don't flood a cancelling task with task_wor=
k
      CVE-2026-99255: io_uring/io-wq: don't hide a link from cancellations
      CVE-2026-99256: dm cache: fix issue with background work locking
      CVE-2026-99258: x86/hyperv: Avoid using per-cpu output page in hv_api=
cid_to_vp_index()
      CVE-2026-99262: [REJECTED]: io_uring/timeout: don't lose a cancel as =
io-wq arms a timeout
      CVE-2026-99263: [REJECTED]: io_uring/poll: avoid retry wakeup loss wh=
en dropping ownership
      CVE-2026-99264: [REJECTED]: io_uring/net: don't retry recv on uncommi=
tted buffers
      CVE-2026-99267: [REJECTED]: io_uring/napi: make stale entries time ou=
t after 60s
      CVE-2026-99268: [REJECTED]: io_uring: wake ring pollers for local tas=
k_work
      CVE-2026-99285: netfilter: nft_byteorder: remove multi-register suppo=
rt
      CVE-2026-100080: xen-netback: Fix UAF when reading statistics data
      CVE-2026-100081: xen-netback: defer xenvif_mcast_addr_list_free()
      CVE-2026-100082: xen-blkback: Avoid UAF when reading I/O statistics
      CVE-2026-0004: TSA variant: TSA-Fill
      CVE-2026-81010: [REJECTED]: io_uring/waitid: honor task_work cancella=
tion
      CVE-2026-89556: module: validate string table section types
      CVE-2026-89866: media: chips-media: wave5: Resume device before setti=
ng EOS flag
      CVE-2026-92499: ext4: validate readdir offset before accessing dirent
      CVE-2026-93241: memcg: bypass the reclaim and oom killer for dying ta=
sks once oom_reaper is done
      CVE-2026-98176: drm/amdkfd: Avoid integer underflow with ffs in EOP r=
ing size calc
      CVE-2026-98177: drm/amdkfd: Avoid integer underflow in EOP ring size =
calculation.
      CVE-2026-98180: drm/msm: RCU-free the scheduler-containing ring and V=
M objects
      CVE-2026-98228: mips: select CONFIG_WEAK_REORDERING_BEYOND_LLSC from =
CONFIG_EYEQ
      CVE-2026-98389: drm/amdgpu: skip gfx switch_power_profile during GPU =
reset
      CVE-2026-98408: watchdog: rzv2h: Avoid division by zero
      CVE-2026-98439: smb/server: cancel async requests when closing connec=
tion
      CVE-2026-98449: smb: client: delete compound mids on send failure bef=
ore unlock
      CVE-2026-98466: KVM: arm64: Transfer the hyp stack pages out of the h=
ost stage-2
      CVE-2026-98674: iio: adc: adi-axi-adc: Initialize state mutex
      CVE-2026-98682: smb: client: drain and invalidate before server-side =
copy/clone
      CVE-2026-98683: smb: client: flush dirty data before zeroing a range
      CVE-2026-98684: smb: client: flush and commit data before querying al=
located ranges
      CVE-2026-98685: smb: client: discard post-EOF pagecache when extendin=
g a file via clone range
      CVE-2026-98714: KVM: SVM: Update control fields on #VMEXIT if and onl=
y if VMRUN succeeded
      CVE-2026-98715: KVM: SVM: Preserve TLB control (i.e. pending TLB flus=
h) on failed VMRUN
      CVE-2026-98786: drm/amd/display: guard dc_sink dereferences in MST mo=
de validation
      CVE-2026-98853: net: gso: limit recursive IP-in-IP segmentation
      CVE-2026-98863: KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting s=
aid pages fails
      CVE-2026-98920: netfs: Fix missing alloc tagging of direct mempool al=
locations
      CVE-2026-98978: namespace: never expire a locked mount
      CVE-2026-98989: namespace: check a recursive bind mount for mount nam=
espace loops
      CVE-2026-98996: fs: don't silently unmount busy mounts
      CVE-2026-99021: regulator: of: fill in supply names in of_regulator_b=
ulk_get_all()
      CVE-2026-99026: net: team: free skb when broadcast has no txable port
      CVE-2026-99076: ipv6: udp: Create exceptions before socket matching
      CVE-2026-99086: dm-integrity: validate the superblock on resume
      CVE-2026-99087: dm-integrity: fix NULL pointer dereference when the '=
R' flag is used
      CVE-2026-99109: smb: client: reject SetEA requests that do not fit th=
e request buffer
      CVE-2026-99122: vsock/vmci: validate packet source for connected sock=
ets
      CVE-2026-99146: drm/i915/dmc: Add sanity check for DMC load address
      CVE-2026-99172: ipc: drop the mqueue mount with kern_unmount() on set=
up failure
      CVE-2026-99240: mm/damon/core: error damos_commit_quota_goal() for ze=
ro target_value
      CVE-2026-99270: tcp: Fix potential UAF in reqsk_timer_handler().
      CVE-2026-99271: ALSA: line6: Clear prev_fbuf on capture buffer releas=
e
      CVE-2026-99273: ksmbd: reserve space for the UTF-16 terminator in str=
eam info
      CVE-2026-99274: smb: client: fix fiemap wild read on empty truncated =
response
      CVE-2026-99281: tun: Require CAP_NET_ADMIN to attach to an ownerless =
device
      CVE-2026-99282: net/sched: sch_teql: fix use-after-free on lower qdis=
c drop
      CVE-2026-99283: netfilter: conntrack: tcp: use UNACK timeout for non-=
closing RST packets
      CVE-2026-99284: net: skbuff: propagate shared-frag marker in skb_zero=
copy()
      CVE-2026-99286: xen-netback: Fix XenBus connection failure cleanup
      CVE-2026-99287: xen-netback: Zero out sring pointers on unmap
      CVE-2026-99288: inet: reject unhashed sockets during established look=
ups
    added commits:
      CIP: Bump version suffix to -cip35 after merge from stable
      arm64: dts: renesas: rzt2h-n2h-evk: Enable RTC support
      arm64: dts: renesas: r9a09g087: Add RTC node
      arm64: dts: renesas: r9a09g077: Add RTC node
      rtc: rzn1: Add support for Renesas RZ/T2H and RZ/N2H SoCs
      rtc: rzn1: Drop trailing comma from OF match table sentinel
      rtc: rzn1: Add OF match data to gate SUBU register access
      rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK for register access
      rtc: rzn1: Consistently use dev_err_probe()
      rtc: rzn1: Use temporary variable for struct device
      rtc: rzn1: Dynamically calculate synchronization delay based on clock=
 rate
      rtc: rzn1: Replace remove callback with devm_add_action_or_reset()
      rtc: rzn1: Use pm_runtime_put_sync()
      rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency to ARCH_RENESAS
      rtc: rzn1: Fix alarm range check truncation on 32-bit systems
      rtc: rzn1: Handle EPROBE_DEFER for optional pps interrupt
      rtc: rzn1: support input frequencies other than 32768Hz
      rtc: rzn1: Disable controller before initialization
      rtc: rzn1: clear interrupts on remove
      rtc: rzn1: implement one-second accuracy for alarms
      rtc: rzn1: reduce register access
      rtc: rzn1: drop superfluous wday calculation
      arm64: dts: renesas: Add LCDC overlays for RZ/T2H and RZ/N2H EVKs
      arm64: dts: renesas: rzt2h-n2h-evk: Use consistent switch notation
      arm64: dts: renesas: r9a09g087: Add DU node
      arm64: dts: renesas: r9a09g087: Add VSPD and FCPVD nodes
      arm64: dts: renesas: r9a09g077: Add DU node
      arm64: dts: renesas: r9a09g077: Add VSPD and FCPVD nodes
      clk: renesas: r9a09g077: Add LCDC and PLL3 clock support for RZ/T2H d=
isplay pipeline
      clk: renesas: r9a09g077: Add RTC clocks
      dt-bindings: clock: renesas,r9a09g077/87: Add PCLKRTC clock ID
      clk: renesas: rzv2h-cpg: Extract PLL calculation helpers into shared =
library
      clk: renesas: rzv2h: Add PLLDSI clk mux support
      clk: renesas: rzv2h-cpg: Use per-SoC PLL reference frequency for calc=
ulations
      clk: renesas: cpg-mssr: Implement dedicated MSTP delay logic for RZ/T=
2H LCDC and RTC
      clk: divider: Fix clk_divider_bestdiv() returning min rate for large =
rate requests
      clk: divider: Add KUnit tests for clk_divider_bestdiv() ULONG_MAX han=
dling
      drm: renesas: rz-du: Add support for RZ/T2H SoC
      drm: renesas: rz-du: Move mode_valid logic to per-SoC clock limits
      drm: renesas: rz-du: Make DU reset control optional for RZ/T2H suppor=
t
      media: renesas: vsp1: Make reset control optional to support platform=
s without a reset line
      media: dt-bindings: media: renesas,vsp1: Document RZ/T2H and RZ/N2H S=
oCs
      media: dt-bindings: media: renesas,fcp: Document RZ/T2H and RZ/N2H So=
Cs
      dt-bindings: clock: renesas,r9a09g077/87: Add LCDC_CLKD clock ID
      dt-bindings: display: renesas,rzg2l-du: Add RZ/T2H and RZ/N2H support
      dt-bindings: display: renesas,rzg2l-du: Refuse port@1 for RZ/G2UL
      ARM: 9463/1: Allow to enable RT
      ARM: 9426/1: vfp: Move sending signals outside of vfp_state_hold()ed =
section.
      ARM: 9425/1: vfp: Use vfp_state_hold() in vfp_support_entry().
      ARM: 9424/1: vfp: Use vfp_state_hold() in vfp_sync_hwstate().
      ARM: 9423/1: vfp: Provide vfp_state_hold() for VFP locking.
      ARM: 9459/1: Disable jump-label on PREEMPT_RT
      arm64: dts: renesas: rzt2h-n2h-evk: Mark XSPI1 boot partitions read-o=
nly
      memory: renesas-rpc-if: Use runtime PM autosuspend after transfers
      memory: renesas-rpc-if: Consolidate command setup register programmin=
g
      memory: renesas-rpc-if: Consolidate XSPI_CDTBUF0 updates in read path
      memory: renesas-rpc-if: Consolidate XSPI_CDTBUF0 updates in write pat=
h
      memory: renesas-rpc-if: Move static bridge configurations out of dirm=
ap hot paths
      memory: renesas-rpc-if: Mark XSPI_CDD1BUF0 as volatile
      spi: spi-rpc-if: Implement 200ms runtime PM autosuspend delay
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable PCIe
      arm64: dts: renesas: r9a09g057: Add PCIe nodes
      clk: renesas: r9a09g057: Add PCIe clocks and reset
      PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
      PCI: rzg3s-host: Prepare System Controller handling for multiple cont=
rollers
      PCI: rzg3s-host: Use shared reset controls for power domain resets
      dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2H(P) support

Best regards,
  Nobuhiro

