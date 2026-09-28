Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5460CA5FA1
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 22:31:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.70401.1790634694371914301
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Sep 2026 15:31:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=AoEII7sm;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1790634680;x=1791844280;bh=
	8ScBu78qi/zLJwOJDCnqBsIh1GmWWquXQHlwUl0w//I=;b=AoEII7smKqyykjRUkr1NEQDI6mR2yQ
	496rwQf75LgAFA4hQzr7YeSFo1yNaWXzQmwOWm14XQLydevRRb0znSNWE88tf0cSD0I0dgqDkkXSR
	l713zsf/jQ0k2DHVxXG3H7klgwRM34IAf9ybqURiqObsuEkE6GoO+pEqNouwBJq8rHZT4TVS2nXMC
	lhPOUnKFBhMWHvUaXQXtFOySPksUDF1lIMDK5DfW2mcz3PT6g9uE/PnuWusq7x2YKXaf8CfiQUOUH
	/vNXMbNScZuMCl2kIusjYErCkU8F5GSjmATKG6KdLeFFvaCo3cmHjSRT/r0fnw6mbUhKDphLt+BvX
	Qn0g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 68SMVJRE2361525; Tue, 29 Sep 2026 07:31:19 +0900
X-Iguazu-Qid: 2rWgMZpjOu3kKbyIeQ
X-Iguazu-QSIG: v=2; s=1; t=1790634679; q=2rWgMZpjOu3kKbyIeQ; m=k3DBq9kfzLvVMxncLjfNVaACnx+yEtuC5dFxHGK0UeA=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4htwyG2FpFz1xnf; Tue, 29 Sep 2026 07:31:18 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVHnDsufDqE7FLzgwwR4H4z69ZVOUkTFS/PL6v3tyEViQvqrNKKXswVBMCOX4Qr0UjzzObsQz30MzXUTmX4VRTjXB66PfcQFSSWSRVpf9oPZrxE/VulDI+0WXZBFhvMAHVBL6pLHThPxpm/fyCO6p5aH6Fl0oV9vi8Hx8cZ44NKPNWSgSCJC2ogqyx4rEsxNr7cafGM2JSSRC1ROoy9yWB24f+ILUuUZJLVJoLhuSz6cHxlhbilfG3Ll2WNiBKP9UKBxCp9gX9ZZJikPVpMfYNkDJT04OvyP+C4MUf5Owriiw32czb917+wOi2Jjj1aeei1weYyT6USMPmD5MwWQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zEiksTi3QdAPvXcHAoDfVRUw6OevKaVtUVAere/KJ0=;
 b=x2gzR8xxYeiGZZrD+gGtdjWBBIB0l50JPlqyx1y3bgpaa692g60oAGafi5OwohDpk5FobSokZj6tMcgsL+sMSxrCXd6C+CIUqD6GTgvq9309vOxy+ZQcxF+5FCBLHbVgYOt01CLhVj2mjoghF7N2ubfs+TPPNqKMgqlxq3gVgR8AXeJt6lgLiNzQumsQ+VbLGznrIBhWt0Eq3Bg6MNUyWfuV83xOE3DudJGZ9AemwntXpF0sQRHAGIwZJf0V32Axj92GfjNA4O+wkoZkwJe9xVMyZRtM5PCAt7X9y7Bk75pJW3bgldHNIizxnxW0ziGF30zzRCR9PQUr5b+4RtFMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>,
        <uli@fpond.eu>, <chris.paterson2@renesas.com>, <pavel@nabladev.com>
Subject: [ANNOUNCE] Release v6.12.111-cip32
Thread-Topic: [ANNOUNCE] Release v6.12.111-cip32
Thread-Index: Ad1PmKYpzXxofZV5TuCRC0FoRq1P1g==
Date: Mon, 28 Sep 2026 22:31:15 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481872E807DB829F4A59D923CD8D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8441:EE_
x-ms-office365-filtering-correlation-id: 9044d8c0-cedb-4e7a-8dc4-08df1db0353c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|4022899009|23010399003|366016|38070700021|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info: 
 ADQLduAsgINWfXYeE9hAGlxxljHbnQvITUnBwSAWnA8FDex6INH7b+J1D2C0G4NGVaSNEI3rNZgi/GIPW/H7wpGZbE8j+91OBs6TIPKVq8NR0wFFD0S0W1/LLze0/g2NTln92dBB9/QFs1kgRyH0oQ8A76oG0ClFh6rrJUfIaUS1zbTOinaqDbOFYFOtxFWiMNzOml1U3ehqb0iCHBrJNEMMx+xrvbaPglie1oNjbuCoP3RfMl5QOFUZo1z1H8aLZfsUBXv32FaWNKU++FkvOCdIz4AuTlTMIUYo1j0s08lTSf1166EdvXBhHzyDZnEnkLW2WEH7EZHAmqWHE/ChS7C3Osub67G1WbuGT8QvPvlQ6Uc45EPdssnNzQtdzYnRMcru5mJJdSLYDkBUYZh0wH0/CjRDPqcu0gxa2ui9GEdofaksbrxSwYATth5K+hyOmMFFPNxzIqb8UCn1gfgC9LXzAOr7NTl5gcqK0j9MyMRz95zetMAfbW5HviU/DR0BnMoWIcIVJJn2gcnsGoInUuD70nC64PhWcuK4ULppO0cx9F1MxQD2aJADx2sM1E11x/NRuaw8SdIXwEAmo+w/S1atdTlTekInRQGOvyaUgriWIHXjp9q0Wghl9oZ3us0KMqtFOForWCqy6UaCfr9wA01V8T1ocZtVuAX8We89DnYaA/fwjiIT+OIB5BiIU04nF8gvzwDSQLqb/DwCham7T3CFYNCEwmuBNgZ+6aCwidY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(4022899009)(23010399003)(366016)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T05Ka1pWczFSTk5xS1VCMDRSTlhFdkVnTzNyZVJOL3E2K3Z0dW0vbDB2?=
 =?iso-2022-jp?B?aTdxNERwM1JMbE5qaE94ekRkV1ByZU15UVl4THlTTW5sdG1wdXNBbnpv?=
 =?iso-2022-jp?B?TVZFbmg3YUNMRm82aEQraVZ5aDJCRGJ2dExycEFya1RmTHhneWFFcTdV?=
 =?iso-2022-jp?B?ZU55QXQ4cWpxdThtSDZvYWR0L1BCZC93L1JzcEFpNzhOT09qRXBTOEdo?=
 =?iso-2022-jp?B?U0RIRis1QVhudk81R2llMU9jVjRlTkRNc0I1eUUyWTZjMjB3M2R6SGYy?=
 =?iso-2022-jp?B?Z2lkK0xPK21MZFBzcG4yaUQ1VkVub0k3dDNNSkt3c0I0WmUwRUxSME44?=
 =?iso-2022-jp?B?MkFKa0ZaZ1dKamw4VDJFN1ViSUR5bmEwTzFCNEFQWVFYQjZLYm8wQUQv?=
 =?iso-2022-jp?B?YW1oT0pUZnlMUDNBcVpxMkxwSTF5RXJ3YmZabW0vWkg3Z0k5SnBGWmdv?=
 =?iso-2022-jp?B?aFd1d2RIdjhGNXE1QTBERmZCQjZsODBzeHAzM2JQQUU4dXBJRXJHRk1J?=
 =?iso-2022-jp?B?YjN2Vm9CUE5WMFNnNFdvTTUzQmNEZU0yOEIyaENiRThkTThiT0g4ZmRM?=
 =?iso-2022-jp?B?YTJuZE96cnFMYU1Rci9WTkFtRDlKL21NRVRadGd3WUMvZWZzSHhkQ0o0?=
 =?iso-2022-jp?B?a3kxOGM2c2NLWUdrM0RVUUlVd0prcmRQdWIrc0dDYVVUTTdUZUt2MFlQ?=
 =?iso-2022-jp?B?YlVuaEJKVDhvVEErT0dXT0pidndlZWxvT0pFSjhheXRrZlh6MVZRZ2JL?=
 =?iso-2022-jp?B?VHdVSjdQaWw3SEY3V21oTS9MNmV0cG1uVmF3ZDFNTXJLOWxNQ1JseWk1?=
 =?iso-2022-jp?B?M2dEMC8ycTB6SDIvOFlkREpkK29PTlhSbEMvOXl0NXBHRUEvbHpWUTBi?=
 =?iso-2022-jp?B?bE9xVExMWjFpdzhSTkpGUHhmaEYyMlVlUHBVNTF5d0xMUXl2eS9jaHFu?=
 =?iso-2022-jp?B?NnEzZEdYSzZLbTdvS3UyK3VwVTdkaHExRnhLQ0ZJdE9ZOEJXN0FrZnNn?=
 =?iso-2022-jp?B?MFcwMXArTWFCRUZyMEFNd3ZRM1ZrbXdING1xT1NINWZaUUM3NkxtTmNv?=
 =?iso-2022-jp?B?ekpLN3Z6aHFvZ3pxL3o4cWxtMWZDVjFKdUZhbm8rM1o5MFRCSTVHWGVV?=
 =?iso-2022-jp?B?eFJ0VlVLN3NXdUx3OUlRWW5VLzgwQm9yYlpBQmY2aDRtUk1NcDVzTXhw?=
 =?iso-2022-jp?B?NlBpa0lmdjJ2YWVCOUUvd1Ruc2xPeUtqM1ZPSmJRSHRScnBxcXlxNSsx?=
 =?iso-2022-jp?B?Y3g2Wm5zT002cmZZRE0vSXVPaXI2YmNmYjFDRUxUTWswVGR6NCtzMFZC?=
 =?iso-2022-jp?B?ak9SYk1JaGhld094eHNjbjR6dTE5bUhqYUk0aUZwU0IxVkhtQUxVYlZ3?=
 =?iso-2022-jp?B?eTM4cTltM1VCN0xIeEJkb3ZoMXhTSEliTEtPRHBlUUhHTis1clZnTVUy?=
 =?iso-2022-jp?B?SFdmaTRFMWdhS05FM2JOd1Z0Z1dtcjJWL2UvUUlYZHdxR3dXdTFsZTA1?=
 =?iso-2022-jp?B?OVRzbGpmR3hpZTRnc1RlZ2xYMlBqU3VKTkZCVnNTZmFCaFltbExpK3F5?=
 =?iso-2022-jp?B?dlFJWDk2RDZyWlVpdm1jKzFtZFdsOGwzaXgrNlVOb1dVSUVtZzNpOWdY?=
 =?iso-2022-jp?B?bHhJT0tZM2hwZ0NJTjdZenpsZ3ZZVWNzbktaQk5lTzYyTTNmSjRBSHpV?=
 =?iso-2022-jp?B?M1Z1ckxHVWM4dy9tWmZpanVpQmorbEtxQW9od0dUamlEV1JOa1c4V2Vz?=
 =?iso-2022-jp?B?YlEwNVRiUFFweHdQeFFwOXp3c2VFUHZ4YlJkdnZHejVKeTBzYVRBdmhZ?=
 =?iso-2022-jp?B?dXpzQ256cVZkTnJ2NFdQT0xFcXRuTWFhbUJEVjI1dDhkMk5vKzdnUEdN?=
 =?iso-2022-jp?B?dGx3Q1pmNTMwQzNrWjdXMVdTcmdwKzZvVWR0azIvKzFZZ2g1cHkzZjFl?=
 =?iso-2022-jp?B?Vi9nbDQycXc3OU94UlJEbnZiUU5rUHhPdTJiSEY4eERJQkpnNXBleHV2?=
 =?iso-2022-jp?B?SGlKa2dZVDJQdW1STTBsVktHRUpqYXNQeS94MnBUeGxNVVI1OFFldmdj?=
 =?iso-2022-jp?B?S2RMY0F2NnBhU29zRFZQaXRCSTd0NWFiRTRhQSt3M2lDc2VRV09henk3?=
 =?iso-2022-jp?B?L2RpQnpZUWltV1puWVFXTG5uQmwvNDhlV2I3Vmc0UUtITHBLQ0o5a2Nj?=
 =?iso-2022-jp?B?UWNYbkd0dVhtWmdFWGtCanV3dlpDZ3UwSTFsQzAyemFBOGc0d3RjZDJQ?=
 =?iso-2022-jp?B?OVM5bkRhNlNrb0hPcTd5UDlKMkFTd3h5R3FFVXJ3QmtaMzRGUmFJYzhL?=
 =?iso-2022-jp?B?WUF3Tnk5UTRNWmV4YnBIRGJLL0hIRkphQXgwTWxIU1VjZEVYODJ1M3dN?=
 =?iso-2022-jp?B?VXowRk8ydWlBKzFSR08wdzhCYkVWa0JSdXFCNDk5UGRKZ2VKUzNtSFI1?=
 =?iso-2022-jp?B?YVd0L3ByZy9hSm1Ha01mc0dkd2NDTStoZzZzaWQwZGxtdzUxKzhLZXdE?=
 =?iso-2022-jp?B?aTgwZExkNU5VaHh6M2V5TTArZlV3SWtsVEdJeEZDR3ZKeEtCNjlGei9U?=
 =?iso-2022-jp?B?Q2VtRzdycz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	pVT+Uy/ObdWaJySJynIMRLjBeGuLZH+2R1wVJqxZ3ZWbYEjt05kRgSmpyrKZXVeMWzyAk7G4OoyV3RBcuIPADSCdieqxMs+a5eP1f41g1Wm9HvN0PuNH9Qo0hhd8vyAjmY4LUYdsnsi0Iyf9PMaRuQ7vf/kvp/0ITeSQbm8vbVjVbr7GzYqWG+CxgCTs+qybu+S6nWnlEBS76+hKp+sKS4cHXdLEh4bGhOiROMzMwU7xE4FjfylgkAxY9KrxWSG8KifWM8xKHkxjfgYHeCmP5rv2SQr3QNMPlOk4lr8UQafnyd1Mugb9HIr/ih9KVqrljtwOj3wl6GPSqRikrIkYhg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9044d8c0-cedb-4e7a-8dc4-08df1db0353c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 22:31:15.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKfySn5znBIHr1LPYgqt1GE4UPtGUiFDNDauYIOiZmz5pDPrDV/SVNCDNkFI9E+L4A7SpZdvzlNJN8ej/cvdw7d0Sg/3kEDcqb6knuIv/fi3pxKnvY+UwijBRT5yl0M8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8441
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Sep 2026 22:31:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24371

Hi all,

CIP kernel team has released Linux kernel v6.12.111-cip32.
The linux-6.12.y-cip tree has been updated base version from v6.12.108 to v=
6.12.111.
And This update includes RTC support, DMAC/RSPI enhancements, and various d=
river fixes
for Renesas RZ ARM64 SoCs.

Information about this release is as follows:

  v6.12.111-cip32:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      f721d8d6df5972522a35438cf356d6a41836aff1
    fixed CVEs:
      CVE-2025-21817: block: mark GFP_NOIO around sysfs ->store()
      CVE-2025-22108: bnxt_en: Mask the bd_cnt field in the TX BD properly
      CVE-2025-22127: f2fs: fix potential deadloop in prepare_compress_over=
write()
      CVE-2025-38205: drm/amd/display: Avoid divide by zero by initializing=
 dummy pitch to 1
      CVE-2025-38621: md: make rdev_addable usable for rcu mode
      CVE-2026-13087: A heap out-of-bounds write vulnerability was found in=
 the Linux kernel's
      RPC-over-RDMA server reply path in net/sunrpc/xprtrdma/svc_rdma_sendt=
o.c.
      When a crafted RPC-over-RDMA client sends a large NFS READ request wi=
th an
      empty Write list and no Reply chunk, the server linearizes the entire
      multi-page reply into a fixed-size 4096-byte heap buffer without boun=
ds
      checking, resulting in a kernel heap overflow. This can lead to denia=
l of
      service via kernel crash or potential code execution through corrupti=
on of
      adjacent kernel heap objects.
      CVE-2026-43344: perf/x86/intel/uncore: Fix die ID init and look up bu=
gs
      CVE-2026-53102: wifi: mt76: Fix memory leak after mt76_connac_mcu_all=
oc_sta_req()
      CVE-2026-53113: wifi: ath11k: fix memory leaks in beacon template set=
up
      CVE-2026-53313: drm/amd/display: Avoid NULL dereference in dc_dmub_sr=
v error paths
      CVE-2026-80833: crypto: sun8i-ss - Remove crypto_rng interface
      CVE-2026-80834: crypto: sun8i-ce - Remove crypto_rng interface
      CVE-2026-80914: Bluetooth: ISO: fix use-after-free of listener socket=
 in iso_conn_ready
      CVE-2026-80928: smack: fix cred UAF in smack_file_send_sigiotask()
      CVE-2026-80930: tpm: tpm_i2c_nuvoton: disable IRQ on wait timeout
      CVE-2026-80931: w1: ds28e17: reject an oversize length on an I2C bloc=
k read
      CVE-2026-80932: vsock/virtio: flush works in dependency order
      CVE-2026-80938: wifi: mt76: mt7615: avoid waiting for mac work under =
the mt76 mutex
      CVE-2026-80940: wifi: rtw88: pci: fix resource leak on failed NAPI se=
tup
      CVE-2026-80941: wifi: rtw88: Fix potential memory leak in rtw_txq_pus=
h_skb()
      CVE-2026-80942: wifi: rtlwifi: rtl8192du: Fix possible memory leak in=
 rtl92du_init_sw_vars()
      CVE-2026-80943: wifi: rtlwifi: rtl8192du: check QoS TID before indexi=
ng tids
      CVE-2026-80944: wifi: mwifiex: Detach sync cmd buffer on interrupted =
wait
      CVE-2026-80947: wifi: rtl8xxxu: fix use-after-free from rx_urb_wq on =
stop
      CVE-2026-80949: wifi: brcmfmac: Fix memory leak in brcmf_sdio_read_co=
ntrol()
      CVE-2026-80951: i3c: master: svc: bound IBI payload to the requested =
max_payload_len
      CVE-2026-80952: i3c: master: Fix info leak and UAF in device unregist=
er path
      CVE-2026-80963: dm-stats: fix a crash if allocation of per-cpu data f=
ails
      CVE-2026-80964: ALSA: virmidi: Check card index validity at probe
      CVE-2026-80965: ALSA: serial-u16550: Check card index validity at pro=
be
      CVE-2026-80966: ALSA: portman2x4: Check card index validity at probe
      CVE-2026-80967: ALSA: pcxhr: initialize mutexes before requesting thr=
eaded IRQ
      CVE-2026-80968: ALSA: mts64: Check card index validity at probe
      CVE-2026-80969: ALSA: mpu401: Check card index validity at probe
      CVE-2026-80971: ALSA: bcd2000: clear the URB pointers on disconnect
      CVE-2026-80972: ALSA: aloop: Check card index validity at probe
      CVE-2026-80973: ALSA: 6fire: bound the MIDI event length from the dev=
ice
      CVE-2026-80974: mfd: sm501: Fix potential memory leaks during remove
      CVE-2026-80976: seg6: reset IP6CB after IPv6 decapsulation
      CVE-2026-80977: net: skbuff: don't touch shared zerocopy state in skb=
_tx_error()
      CVE-2026-80978: net: cap advertised IP tunnel headroom
      CVE-2026-80979: net/smc: unregister the connection before draining th=
e rx tasklet
      CVE-2026-80982: net/smc: fix use-after-free in smc_rx_pipe_buf_releas=
e()
      CVE-2026-80983: net/smc: fix socket refcount leak in smc_switch_conns=
()
      CVE-2026-80984: net/smc: do not dereference an unset send buffer on t=
he SMC-D teardown path
      CVE-2026-80987: NTB: ntb_transport: Reject oversized TX buffers
      CVE-2026-80988: NTB: ntb_transport: Fail TX enqueue when the QP link =
is down
      CVE-2026-80989: net: thunderbolt: Mark the connection down when bring=
ing it up fails
      CVE-2026-80990: net: thunderbolt: Release the Rx HopID that was hande=
d out on mismatch
      CVE-2026-80991: net: ravb: serialize PTP clock teardown
      CVE-2026-80992: net: ravb: avoid dereferencing an invalid PTP clock
      CVE-2026-80994: net: openvswitch: fix flow mask use-after-free on flo=
w deletion
      CVE-2026-80996: net: l2tp: do not propagate multicast notification er=
rors
      CVE-2026-80997: net: ipa: fix stalled modem TX queue after runtime re=
sume
      CVE-2026-80999: net: dsa: realtek: use gpiod_set_value_cansleep for r=
eset GPIO
      CVE-2026-81000: net: tun: bound receive headroom
      CVE-2026-81001: slip: fix use-after-free in sl_sync()
      CVE-2026-81002: xdp: fix zero-copy frame layout
      CVE-2026-81003: net/iucv: filter frames in afiucv_hs_rcv() by ingress=
 device
      CVE-2026-81005: ipmi: si: Fix NULL pointer dereference after failed r=
egistration
      CVE-2026-81007: ipmi: ipmb: validate write message length
      CVE-2026-81008: interconnect: Fix use after free in icc_get() and of_=
icc_get_by_index()
      CVE-2026-81011: platform/x86: hp-bioscfg: pass validated element coun=
t to package parsers
      CVE-2026-81012: platform/x86: hp-bioscfg: fix off-by-one write in hp_=
get_string_from_buffer()
      CVE-2026-81013: platform/x86: hp-bioscfg: fix heap OOB read on empty =
password write
      CVE-2026-81014: platform/x86: hp-bioscfg: fix heap OOB read in sk_sto=
re() and kek_store()
      CVE-2026-81017: platform/chrome: sensorhub: Bound the EC-reported sen=
sor number
      CVE-2026-89438: platform/x86: ISST: Validate logical CPU id and clos =
id
      CVE-2026-89439: platform/x86: ISST: Add a NULL check for sst_inst[]
      CVE-2026-89440: mmc: via-sdmmc: stop card-detect handling on probe fa=
ilure
      CVE-2026-89442: platform/x86: ISST: Validate socket ID in clos_assoc =
ioctl
      CVE-2026-89443: platform/x86: ISST: Validate level in perf mask ioctl=
s
      CVE-2026-89444: platform/x86: dell-wmi-sysman: Don't hex dump attribu=
te security buffer
      CVE-2026-89448: iommu/vt-d: Force requesting ACS when tboot is enable=
d
      CVE-2026-89451: iommu/sva: Set handle->dev before the SVA handle is v=
isible
      CVE-2026-89453: iommu/amd: Put PCI device after handling PPR faults
      CVE-2026-89454: PCI: plda: Fix IRQ domain leaks in the error paths of=
 plda_init_interrupts()
      CVE-2026-89455: PCI: plda: Fix use-after-free of event IRQs during te=
ardown
      CVE-2026-89456: s390/dasd: Propagate partial completion length across=
 ERP recovery
      CVE-2026-89457: s390/dasd: Guard sysfs discipline callbacks against u=
nallocated private data
      CVE-2026-89458: s390/dasd: Do not complete a failed ESE read as succe=
ssful
      CVE-2026-89460: s390/cpum_cf: Handle CPU hotplug via prepare/dead cal=
lbacks
      CVE-2026-89461: power: supply: max17040: synchronize work cancellatio=
n on suspend
      CVE-2026-89462: power: supply: max17040: propagate register read erro=
rs
      CVE-2026-89463: power: supply: ucs1002: fix use-after-free on remove
      CVE-2026-89464: power: supply: twl4030_charger: cancel workers via de=
vm
      CVE-2026-89465: power: supply: rt9455: quiesce delayed work before te=
ardown
      CVE-2026-89466: power: supply: qcom_battmgr: terminate the strings fr=
om firmware
      CVE-2026-89468: power: supply: lp8788-charger: fix use-after-free on =
remove
      CVE-2026-89469: power: supply: lp8727: fix use-after-free in lp8727_r=
elease_irq()
      CVE-2026-89470: power: supply: cros_usbpd: Limit port counts to EC_US=
B_PD_MAX_PORTS
      CVE-2026-89471: power: supply: cros_usbpd-charger: bound the EC-repor=
ted port count
      CVE-2026-89472: power: supply: charger-manager: register regulators b=
efore exposing sysfs
      CVE-2026-89473: power: supply: bq25890: Fix power_supply reference le=
ak
      CVE-2026-89474: power: supply: bq256xx: drain usb_work before freeing=
 the charger
      CVE-2026-89475: power: supply: bq24257: fix use-after-free on remove
      CVE-2026-89476: sctp: fix stream->outcnt underflow on duplicate RECON=
F responses
      CVE-2026-89477: sctp: fix NULL deref on untransmitted RECONF completi=
on
      CVE-2026-89478: sctp: drop a chunk if its transport was removed
      CVE-2026-89479: sctp: stop processing a packet once its association i=
s deleted
      CVE-2026-89480: nvme-tcp: reject a read that transferred too few byte=
s
      CVE-2026-89481: nvme-tcp: fix host memory disclosure on R2T for a rea=
d command
      CVE-2026-89482: nvme-tcp: do not accept C2HData based on blk_rq_paylo=
ad_bytes() alone
      CVE-2026-89483: nvme: zero the discard fallback page
      CVE-2026-89484: lockd: fix NULL dereference on lockowner allocation f=
ailure
      CVE-2026-89485: lockd: pin next file across nlm_inspect_file lock-dro=
p
      CVE-2026-89487: openvswitch: only skb_tx_error() a packet we are abou=
t to drop
      CVE-2026-89489: openrisc: fix arbitrary kernel memory access via or1k=
_atomic syscall
      CVE-2026-89490: ocfs2: fix readdir position truncation on 32-bit kern=
els
      CVE-2026-89491: ocfs2: cluster: don't sleep while holding o2hb_live_l=
ock in o2hb_region_pin()
      CVE-2026-89493: ocfs2: validate rl_used against rl_count in refcount =
block validator
      CVE-2026-89494: ocfs2: validate lengths in dlm_mig_lockres_handler
      CVE-2026-89495: ocfs2: bound namelen in dlm_migrate_request_handler
      CVE-2026-89496: ocfs2: always run deallocs on copy-on-write completio=
n
      CVE-2026-89497: orangefs: skip leading spaces before parsing client d=
ebug masks
      CVE-2026-89498: orangefs: fix double-free of trailer_buf on readdir c=
opy failure
      CVE-2026-89501: ring-buffer: Hold cpu_buffer::lock when resizing a su=
bbuf
      CVE-2026-89502: ring-buffer: Free cpu_buffer::free_page with subbuf_o=
rder
      CVE-2026-89504: regulator: as3722_get_regulator_dt_data: fix prematur=
e of_node_put leaving dangling of_node pointer
      CVE-2026-89508: RDMA/ucma: Lock the handler in ucma_set_ib_path()
      CVE-2026-89510: RDMA/cxgb4: Cancel reg_work before freeing device on =
remove
      CVE-2026-89511: qede: Fix NULL pointer dereference in TPA fragment pr=
ocessing
      CVE-2026-89512: remoteproc: scp: Fix device reference leak on failed =
lookup
      CVE-2026-89515: scsi: core: Fill in DMA padding bytes in scsi_alloc_s=
gtables()
      CVE-2026-89524: wifi: ath6kl: clamp assoc request/response lengths be=
fore subtracting IE offsets
      CVE-2026-89525: udf: reject VAT indexes equal to the entry count
      CVE-2026-89526: svcrdma: Validate Read chunk positions before reconst=
ruction
      CVE-2026-89530: svcrdma: Reject inline replies that overflow the pull=
-up buffer
      CVE-2026-89531: svcrdma: Reject connection when transport allocation =
fails
      CVE-2026-89532: svcrdma: Fix pcl_for_each_segment for empty chunks
      CVE-2026-89533: svcrdma: Fix offset arithmetic in read_chunk_range
      CVE-2026-89536: SUNRPC: wait for in-flight client TLS handshake callb=
ack
      CVE-2026-89538: SUNRPC: Reject krb5 v2 wrap tokens with oversized ec =
field
      CVE-2026-89539: SUNRPC: reject duplicate CREDS_VALUE options
      CVE-2026-89540: sunrpc: init gssp_lock before publishing proc entry
      CVE-2026-89541: SUNRPC: harden gss_unwrap_resp_priv length checks
      CVE-2026-89542: SUNRPC: harden gss_krb5_unwrap_v2 against short token=
s
      CVE-2026-89547: SUNRPC: Check svc pool percpu counter allocation
      CVE-2026-89548: SUNRPC: always drain cache_cleaner before destroying =
a cache_detail
      CVE-2026-89549: sunrpc: route to a populated pool in svc_pool_for_cpu=
()
      CVE-2026-89550: SUNRPC: svcauth_gss: enforce krb5 token minimum lengt=
h
      CVE-2026-89551: SUNRPC: xdr_buf_trim: clamp buf->len to avoid underfl=
ow
      CVE-2026-89552: params: fix charp corruption on allocation failure
      CVE-2026-89553: nouveau/gem: reserve the bo in the info ioctl around =
the vma lookup
      CVE-2026-89554: mptcp: fix uninitialized local_id in syncookie MP_JOI=
N reconstruction
      CVE-2026-89555: mpls: reload header after pskb_may_pull()
      CVE-2026-89557: md: do overflow check for sb->bblog_shift in super_1_=
load()
      CVE-2026-89558: md/raid10: fix still_degraded being inverted in raid1=
0_sync_request()
      CVE-2026-89559: libnvdimm/labels: Prevent integer overflow in __nd_la=
bel_validate()
      CVE-2026-89562: ip6_gre: fix hardware header length for NBMA tunnels
      CVE-2026-89563: ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
      CVE-2026-89565: ipip: fix skb leak in collect_md mode when metadata_d=
st allocation fails
      CVE-2026-89566: jbd2: check need_resched() when skipping busy checkpo=
int buffers
      CVE-2026-89567: jbd2: bound shrinker scans by examined checkpoint buf=
fers
      CVE-2026-89569: Bluetooth: RFCOMM: serialize security confirmation ha=
ndling
      CVE-2026-89573: dm array: reject an array block whose value size is n=
ot the caller's
      CVE-2026-89574: dm array: validate array block headers on read
      CVE-2026-89575: dm raid1: reserve space for NUL-terminator in build_c=
onstructor_string()
      CVE-2026-89576: dm-era: fix shadowed superblock leak on take-snap fai=
lure
      CVE-2026-89579: bpf: Harden bloom filter sizing and indexing on 32-bi=
t kernels
      CVE-2026-89580: bpf: Disable preemption in __bpf_get_stack
      CVE-2026-89581: bpf, x86: Fix per-CPU address resolution into an exte=
nded register
      CVE-2026-89582: bnx2x: fix double free in bnx2x_init_firmware() error=
 path
      CVE-2026-89583: Bluetooth: eir: Fix OOB read in eir_get_service_data(=
)
      CVE-2026-89585: auxdisplay: charlcd: cancel backlight work on registr=
ation failure
      CVE-2026-89586: ata: libata-scsi: fix DSM TRIM for sector sizes large=
r than 2048 bytes
      CVE-2026-89587: ACPI: pfr_update: fix stack buffer overflow in query_=
capability()
      CVE-2026-89588: ACPI: APEI: GHES: fix ARM section length accounting a=
fter header
      CVE-2026-89594: hsi: omap_ssi_core: fix missing DMA mask setup for SS=
I controller device
      CVE-2026-89596: forcedeth: fix off-by-one when saving/restoring non-P=
CI config space
      CVE-2026-89597: fbdev: uvesafb: unregister connector callback on init=
 failure
      CVE-2026-89598: fbdev: ssd1307fb: defer I2C transfers from damage cal=
lbacks
      CVE-2026-89599: fbdev: omapfb: panel-dsi-cm: initialize lock before r=
egistering display
      CVE-2026-89604: efivarfs: Rate limit statfs() handler
      CVE-2026-89605: ecryptfs: release message context on send failure
      CVE-2026-89606: ecryptfs: reject too-small tag 70 packets
      CVE-2026-89607: ecryptfs: reject oversized encrypted_key_size in pars=
e_tag_3_packet
      CVE-2026-89608: ecryptfs: pass packet set buffer size to parser
      CVE-2026-89609: ecryptfs: hold msg ctx list lock when cleaning daemon=
 queue
      CVE-2026-89615: fs/ntfs3: bound page_lcns[] index by the log record
      CVE-2026-89616: fs/ntfs3: fix info-leak on partial LZNT decompress in=
 ni_read_frame()
      CVE-2026-89617: fs/ntfs3: validate dirty page table on log replay
      CVE-2026-89618: eventfs: Initialize ei->children and ei->list in init=
_ei()
      CVE-2026-89621: HID: mcp2221: validate report size in mcp2221_raw_eve=
nt()
      CVE-2026-89623: HID: mcp2221: stop device IO before hid_hw_stop
      CVE-2026-89626: HID: sensor: custom: Fix field sysfs group cleanup on=
 failure
      CVE-2026-89627: HID: roccat: free buffered reports when destroying de=
vice
      CVE-2026-89628: HID: picolcd: clamp eeprom debugfs read to bytes actu=
ally received
      CVE-2026-89634: smb: client: fix ALIGN() overflow in symlink_data() e=
rror context loop
      CVE-2026-89636: smb: client: clear ce->tgthint in free_tgts()
      CVE-2026-89640: cifs: fix loff_t underflow in cifs_remap_file_range()=
 when len =3D=3D 0
      CVE-2026-89643: audit: avoid dropping live tree ref on fsnotify rule =
autoremove
      CVE-2026-89645: btrfs: drop recovered reloc root refs on recovery fai=
lure
      CVE-2026-89647: ceph: do not repeat ceph_trim_dentries() if no progre=
ss possible
      CVE-2026-89649: ceph: bound xattr value length in __build_xattrs()
      CVE-2026-89650: ceph: bound num_export_targets array for mds info v2/=
v3
      CVE-2026-89651: ceph: bound MDSCapAuth path and fs_name decode in han=
dle_session()
      CVE-2026-89652: ceph: bound copied dentry name length in NFS export g=
et_name
      CVE-2026-89653: ceph: reject export_targets ranks >=3D CEPH_MAX_MDS i=
n mdsmap decode
      CVE-2026-89655: ceph: fix UAF in __kick_flushing_caps() on cf entry f=
reed during unlock
      CVE-2026-89656: libceph: reject buckets with mismatched CRUSH ids
      CVE-2026-89657: libceph: validate OSD extent maps before cursor advan=
ce
      CVE-2026-89658: NFSD: Prevent client use-after-free during NFSv4.0 re=
voked-state cleanup
      CVE-2026-89662: NFSD: Prevent lock owner use-after-free during client=
 teardown
      CVE-2026-89663: nfsd: revoke copy-notify stateids before dropping the=
ir reference
      CVE-2026-89665: nfsd: reject out-of-range useconds in NFSv2 SETATTR/C=
REATE
      CVE-2026-89666: nfsd: reject out-of-range nseconds in NFSv3 SETATTR a=
nd create ops
      CVE-2026-89669: nfsd: initialize copy-notify stateid before publishin=
g it
      CVE-2026-89671: nfsd: gate nfs3 setacl by argp->mask
      CVE-2026-89672: nfsd: gate nfs2 setacl by argp->mask
      CVE-2026-89673: nfsd: fix XDR padding calculation in ff_encode_getdev=
iceinfo
      CVE-2026-89674: nfsd: fix XDR length calculation in nfsd4_ff_encode_l=
ayoutget
      CVE-2026-89680: nfsd: fix nfsd_file leak on inter-server COPY setup f=
ailure
      CVE-2026-89683: nfsd: fix dentry ref leak on V4ROOT export filehandle=
 lookup
      CVE-2026-89684: nfsd: fix cpntf publish race in nfs4_init_cp_state
      CVE-2026-89686: nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on rac=
ing delegation revoke
      CVE-2026-89688: nfsd: drop the stateid, not the stateowner, on seqid_=
op replay retry
      CVE-2026-89690: nfsd: defer vfree of compound ops to fix rpc_status U=
AF
      CVE-2026-89691: nfsd: clear opcnt on compound arg release to prevent =
OOB read
      CVE-2026-89694: nfsd: check client ownership when cancelling a copy-n=
otify stateid
      CVE-2026-89696: nfsd: block non-SAVEFH ops after FOREIGN PUTFH to pre=
vent NULL deref
      CVE-2026-89697: nfsd: add fh_want_write() for early-verified SETATTR =
in nfsd_proc_setattr()
      CVE-2026-89699: nfsd: validate symlink target length in NFSv4 CREATE
      CVE-2026-89702: nfsd: size fh_verify server sockaddr slot by xpt_loca=
llen
      CVE-2026-89703: nfsd: set SC_STATUS_FREED in nfsd4_drop_revoked_stid =
for delegations
      CVE-2026-89704: nfsd: sample writeback error cursor before async COPY=
 loop
      CVE-2026-89706: nfsd: Reset write verifier when async COPY writeback =
fails
      CVE-2026-89707: nfsd: release path refs on follow_down() error
      CVE-2026-89710: NFSv4.1: fix layout segment leak on the pnfs_layout_p=
rocess() forget path
      CVE-2026-89711: NFSD: remove flawed WARN_ON_ONCE from nfsd_mode_check
      CVE-2026-89712: NFSD: restart ssc_expire_umount walk after dropping n=
fsd_ssc_lock
      CVE-2026-89713: NFSD: check truncate permission under inode lock
      CVE-2026-89720: ubifs: fix out-of-bounds read in signature length che=
ck
      CVE-2026-89723: nilfs2: fix slab-out-of-bounds in nilfs_direct_propag=
ate after truncation
      CVE-2026-89724: media: vicodec: fix out-of-bounds write in FWHT encod=
er
      CVE-2026-89725: media: cec: stm32: prevent out-of-bounds write on RX =
overflow
      CVE-2026-89726: lib/ucs2_string.c: fix out-of-bounds read in ucs2_str=
nlen()
      CVE-2026-89729: HID: sensor-hub: Fix out-of-bounds write in sensor_hu=
b_get_feature
      CVE-2026-89730: fpga: altera-cvp: Avoid out-of-bounds read in trailin=
g byte write
      CVE-2026-89732: usb: gadget: f_fs: Prevent deadlock during ep0 read l=
oop
      CVE-2026-89733: usb: gadget: uvc: fix dangling pointers in uvc_functi=
on_bind() and uvc_function_unbind()
      CVE-2026-89735: usb: gadget: midi2: remove default configfs groups on=
 teardown
      CVE-2026-89736: usb: gadget: u_audio: Fix use-after-free on sound car=
d disconnect
      CVE-2026-89738: usb: gadget: at91_udc: drain polled-VBUS timer/work b=
efore udc is freed
      CVE-2026-89740: serial: imx: serialize imx_uart_ports[] lifetime
      CVE-2026-89741: Revert "media: v4l2-dev: fix error handling in __vide=
o_register_device()"
      CVE-2026-89742: rapidio: mport_cdev: fix use-after-free in dma_req_fr=
ee()
      CVE-2026-89743: misc: nsm: bound the device-reported response length
      CVE-2026-89744: device property: fix infinite loop in fwnode_for_each=
_child_node()
      CVE-2026-89746: tracing: Fix use-after-free with same-name named trig=
gers
      CVE-2026-89747: tracing: Fix use-after-free in trace_pipe read on sub=
-buffer order change
      CVE-2026-89749: tracing: Fix crash passing ERR_PTR to kthread_stop()
      CVE-2026-89750: tracing/user_events: Clear copied tracing state befor=
e fork duplication
      CVE-2026-89751: x86/tdx: Fix off-by-one in port I/O handling
      CVE-2026-89752: mm: memcg: stop reclaim when a limit update is supers=
eded
      CVE-2026-89753: mm/vmscan: report RCU-tasks quiescent states in shrin=
k_lruvec()
      CVE-2026-89756: mm/migrate: report RCU-tasks quiescent states in migr=
ate_pages_batch()
      CVE-2026-89759: mm/kmemleak: avoid soft lockup when scanning task sta=
cks
      CVE-2026-89761: apparmor: fix out-of-bounds write when null terminati=
ng a label vec
      CVE-2026-89762: apparmor: fix cred UAF caused by begin_current_label_=
crit_section()
      CVE-2026-89765: timers/itimer: Zero-init old itimerval before copy to=
 userspace
      CVE-2026-89768: fs: fix user path of nested backing files
      CVE-2026-89771: ring-buffer: Fix subbuf resize race with ring buffer =
readers
      CVE-2024-52560: fs/ntfs3: Mark inode as bad as soon as error detected=
 in mi_enum_attr()
      CVE-2025-38266: pinctrl: mediatek: eint: Fix invalid pointer derefere=
nce for v1 platforms
      CVE-2025-40295: fscrypt: fix left shift underflow when inode->i_blkbi=
ts > PAGE_SHIFT
      CVE-2025-71142: cpuset: fix warning when disabling remote partition
      CVE-2026-23137: of: unittest: Fix memory leak in unittest_data_add()
      CVE-2026-43122: [REJECTED]: ACPI: processor: Update cpuidle driver ch=
eck in __acpi_processor_start()
      CVE-2026-43198: tcp: fix potential race in tcp_v6_syn_recv_sock()
      CVE-2026-52944: ksmbd: fix FSCTL permission bypass by adding a permis=
sion check for FSCTL_SET_SPARSE
      CVE-2026-53010: ksmbd: fix use-after-free in smb2_open during durable=
 reconnect
      CVE-2026-53250: xsk: cache csum_start/csum_offset to fix TOCTOU in xs=
k_skb_metadata()
      CVE-2026-64016: ksmbd: fix durable reconnect error path file lifetime
      CVE-2026-64031: erofs: fix managed cache race for unaligned extents
      CVE-2026-64058: netfs: Fix netfs_read_folio() to wait on writeback
      CVE-2026-64210: net/mlx5e: xsk: Fix unlocked writing to ICOSQ
      CVE-2026-72131: nvme-apple: Prevent shared tags across queues on Appl=
e A11
      CVE-2026-74268: tcp: clear sock_ops cb flags before force-closing a c=
hild socket
      CVE-2026-74334: RDMA/nldev: Fix locking when accessing mr->pd
      CVE-2026-74371: bpf: fix BPF_PROG_QUERY OOB write and cgroup backward=
 compat
      CVE-2026-80671: perf sched: Fix register_pid() overflow, strcpy, and =
BUG_ON
      CVE-2026-80878: afs: Fix leak of ungot volume
      CVE-2026-80933: wifi: mt76: mt7996: validate default EEPROM firmware =
size
      CVE-2026-89488: openvswitch: Fix CT limit teardown use-after-free
      CVE-2026-89560: landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whi=
teout creation
      CVE-2026-89593: hugetlb: only adjust reservation during unmapping if =
mapcount is 0
      CVE-2026-89595: fsnotify: Fix stale object mask after concurrent mark=
 updates
      CVE-2026-89603: entry: Fix seccomp bypass after ptrace with TSYNC
      CVE-2026-89776: vxlan: vnifilter: enforce exact length of GROUP/GROUP=
6 attributes
      CVE-2026-89777: vfio/pci: clear vdev->msi_perm after freeing it on in=
it failure
      CVE-2026-89778: isofs: fix out-of-bounds page array access on empty z=
isofs block
      CVE-2026-89779: fs/ntfs3: validate ef->size covers the record's name =
and value
      CVE-2026-89780: net: qualcomm: rmnet: restore skb->dev on deaggregate=
d frames
      CVE-2026-89781: fs/ntfs3: fix out-of-bounds read in read_log_rec_buf(=
)
      CVE-2026-89782: fs/ntfs3: reject restart table growth beyond U16_MAX =
entries
      CVE-2026-89783: xfrm6: fix out-of-bounds write in xfrm6_input_addr() =
when secpath is full
      CVE-2026-89784: SUNRPC: check rpc_sockaddr2uaddr() return value in rp=
cb_register_inet4/6
      CVE-2026-89785: fs/ntfs3: fix out-of-bounds read of INDEX_ROOT in rep=
arse/objid init
      CVE-2026-89786: ext4: fix out-of-bounds read in ext4_read_inline_dir(=
)
      CVE-2026-89787: ext4: check dir entry fits before reading the hash tr=
ailer in ext4_search_dir()
      CVE-2026-89789: gtp: add synchronize_net() in gtp_newlink() error pat=
h to prevent use-after-free
      CVE-2026-89793: ublk: clear VM_MAYWRITE on read-only ublk char device=
 mmap
      CVE-2026-89794: ksmbd: zero pipe read compound padding
      CVE-2026-89800: drm/nouveau/uvmm: clear the dirty flag when unwinding=
 an OP_UNMAP_SPARSE
      CVE-2026-89801: drm/nouveau/uvmm: fix premature region free on failed=
 OP_UNMAP_SPARSE
      CVE-2026-89802: drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_=
SPARSE op
      CVE-2026-89803: drm/nouveau: unsubscribe the channel-kill event befor=
e the fence context
      CVE-2026-89807: drm/amdkfd: guard against NULL restore_mqd in CRIU qu=
eue restore
      CVE-2026-89816: drm: Fix drm_crtc_commit leak if signaled when PAGE_F=
LIP_EVENT is used
      CVE-2026-89817: drm/gud: NUL-terminate TV mode names read from the de=
vice
      CVE-2026-89818: drm/amdgpu/vcn: fix integer overflow in dec_msg buffe=
r count check
      CVE-2026-89819: drm/amd/display: validate plane degamma LUT size for =
private color prop
      CVE-2026-89821: drm/amd/display: avoid divide-by-zero in __is_lut_lin=
ear()
      CVE-2026-89822: drm/i915: Guard against NULL driver_data in i915_pci_=
probe()
      CVE-2026-89823: drm: fix race between partial drm_dev_register() fail=
ure and ioctl
      CVE-2026-89824: drm/panel-edp: fix i2c adapter leak on probe failure
      CVE-2026-89825: drm/panthor: fix firmware control interface bounds ch=
ecks
      CVE-2026-89830: f2fs: fix valid block count leak on data block alloca=
tion failure
      CVE-2026-89834: f2fs: fix to migrate all curseg types during free_seg=
ment_range
      CVE-2026-89835: f2fs: avoid NULL checkpoint thread access in sysfs
      CVE-2026-89839: f2fs: use the mount idmap for the owner check in f2fs=
_xattr_advise_set()
      CVE-2026-89842: scsi: qla2xxx: Skip NVMe LS reject IOCB when FW not s=
tarted
      CVE-2026-89843: scsi: qla2xxx: Zero-init bsg stack buffers to avoid i=
nfo leak
      CVE-2026-89844: scsi: qla2xxx: Hold vport_slock for host map update i=
n report ID acquisition
      CVE-2026-89845: scsi: qla2xxx: Avoid req_q_map double-read in qla2x00=
_error_entry()
      CVE-2026-89846: scsi: qla2xxx: Bound rsp_info_len to avoid OOB sense-=
data read
      CVE-2026-89847: scsi: qla2xxx: Avoid double completion in async IOCB =
timeout
      CVE-2026-89848: scsi: qla2xxx: Quiesce response IRQ before freeing re=
quest queue
      CVE-2026-89849: scsi: qla2xxx: Reject non-SCSI SRB on status IOCB fas=
t path
      CVE-2026-89850: scsi: qla2xxx: Don't query firmware state while chip =
is down
      CVE-2026-89851: scsi: qla2xxx: Fix FCE trace enable parsing in debugf=
s
      CVE-2026-89852: scsi: qla2xxx: Zero mailbox struct in qla2x00_get_fir=
mware_state()
      CVE-2026-89853: scsi: qla2xxx: Fix FCE trace use-after-free during fi=
rmware dump
      CVE-2026-89854: scsi: qla2xxx: Fix cs84xx use-after-free on host tear=
down
      CVE-2026-89855: scsi: qla2xxx: Serialize flash version read in reset =
handler
      CVE-2026-89856: scsi: qla2xxx: Clamp MSI-X derived queue counts to av=
oid truncation
      CVE-2026-89857: scsi: qla2xxx: Hold qpair lock when sending NVMe LS r=
eject
      CVE-2026-89858: scsi: qla2xxx: Bound image count in qla2x00_update_fr=
u_versions()
      CVE-2026-89860: scsi: qla2xxx: Initialize NVMe abort_work once at sub=
mission
      CVE-2026-89861: scsi: qla2xxx: Hold vport reference in qla24xx_report=
_id_acquisition()
      CVE-2026-89863: scsi: qla2xxx: edif: Fix NULL pointer deref in RX SA =
delete check
      CVE-2026-89864: scsi: qla2xxx: Bound i2c->length in I2C bsg handlers
      CVE-2026-89865: scsi: qla2xxx: Zero SFP DMA buffer in FRU/I2C bsg han=
dlers
      CVE-2026-89870: media: zoran: Avoid freeing a registered video_device=
 twice
      CVE-2026-89871: media: video-i2c: fix kthread error pointer left in k=
thread_vid_cap on failure
      CVE-2026-89872: media: v4l2-fwnode: Fix fwnode leak in v4l2_fwnode_pa=
rse_link
      CVE-2026-89874: media: v4l2-async: avoid deleting unlinked ASC entry =
on link error
      CVE-2026-89876: media: tda18250: fix possible integer overflow
      CVE-2026-89877: media: saa7164: fix cleanup on resource allocation fa=
ilure
      CVE-2026-89878: media: s2255: check firmware size before reading trai=
ling marker
      CVE-2026-89879: media: s2255: bound JPEG frame size before copying in=
to the buffer
      CVE-2026-89880: media: rtl2832_sdr: release URBs and stream buffers o=
n start_streaming() failure
      CVE-2026-89881: media: rtl2832_sdr: use vb2_video_unregister_device()=
 on remove to fix DMA leak
      CVE-2026-89883: media: rc: sunxi-cir: Unregister rc device on probe f=
ailure
      CVE-2026-89884: media: platform: mtk-mdp3: fix NULL deref on failed S=
CP lookup
      CVE-2026-89885: media: platform: mtk-mdp3: Fix SCP device refcounting
      CVE-2026-89886: media: intel/ipu6: fix async notifier cleanup leak on=
 parse error
      CVE-2026-89887: media: i2c: ov7740: fix use-after-destroy in remove
      CVE-2026-89888: media: i2c: ov02a10: fix endpoint parsing use-after-f=
ree
      CVE-2026-89890: media: go7007: defer the ALSA v4l2 put until card rel=
ease
      CVE-2026-89891: media: em28xx: fix use-after-free of dev_next->devlis=
t on disconnect
      CVE-2026-89892: media: em28xx: defer audio-only extension registratio=
n
      CVE-2026-89893: media: cx23885: cancel NetUP CI work before teardown
      CVE-2026-89894: media: cx231xx: reject geometry changes while the VBI=
 queue is busy
      CVE-2026-89895: media: cobalt: Avoid freeing ALSA private data twice
      CVE-2026-89896: media: cedrus: fix memory leak in cedrus_init_ctrls()
      CVE-2026-89897: media: cec: Serialize exclusive follower delivery
      CVE-2026-89898: media: cec: extron-da-hd-4k-plus: add sanity check
      CVE-2026-89899: media: cec: disable delayed work before freeing an in=
terrupted transmit
      CVE-2026-89900: media: cec: core: Fix kmemleak due to missed rc_free_=
device() call
      CVE-2026-89901: media: airspy: use vb2_video_unregister_device() on d=
isconnect to fix NULL deref
      CVE-2026-89902: LoongArch: Avoid preempt count underflow without prob=
e
      CVE-2026-89903: LoongArch: Do not save/restore percpu base register i=
n rethook trampoline
      CVE-2026-89904: LoongArch: Fix acpi_package_ids[] array overflow
      CVE-2026-89908: LoongArch: KVM: Preserve memslot arch flags on KVM_MR=
_FLAGS_ONLY
      CVE-2026-89909: LoongArch: KVM: Free init resources if kvm_init() fai=
ls
      CVE-2026-89922: KVM: s390: Take srcu when importing watchpoint data
      CVE-2026-89923: KVM: s390: Free guest debug data on vcpu destroy
      CVE-2026-89924: KVM: s390: Fix old_data leak in guest debug error pat=
h
      CVE-2026-89925: KVM: s390: Fix memory leak in guest debug handling
      CVE-2026-89926: KVM: s390: Fix length check __import_wp_info()
      CVE-2026-89927: KVM: x86: hyper-v: Clamp stimer deadline to avoid liv=
elock
      CVE-2026-89929: KVM: nVM: Ensure INVVPID is emulated on the correct p=
hysical CPU
      CVE-2026-89930: KVM: nVMX: Service local TLB flushes on failed nested=
 VM-Enter
      CVE-2026-89931: KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is c=
leared on VM-Exit
      CVE-2026-89932: KVM: nVMX: Always flush vpid02 on first use
      CVE-2026-89933: iio: pressure: dps310: fix NULL pointer dereference o=
n ACPI probe
      CVE-2026-89934: iio: light: ltrf216a: fix runtime PM reference leak i=
n error path
      CVE-2026-89936: iio: dac: m62332: Fix regulator reference count imbal=
ance
      CVE-2026-89937: iio: chemical: sgp30: Handle IAQ thread creation fail=
ure
      CVE-2026-89938: iio: chemical: atlas-sensor: use iio_trigger_poll_nes=
ted() to fix remove UAF
      CVE-2026-89939: iio: chemical: atlas-sensor: fix PM reference leak in=
 buffer postenable
      CVE-2026-89940: iio: buffer: Tie IIO dma fence lock lifetime to the f=
ence
      CVE-2026-89941: iio: buffer: Make IIO DMA fence release RCU-safe
      CVE-2026-89942: iio: buffer: Fix potential use-after-free in anonymou=
s buffer release
      CVE-2026-89943: ASoC: loongson: Fix error handling in ACPI property p=
arsing
      CVE-2026-89944: ASoC: hdac_hda: Fix hlink refcount leak on component =
registration failure
      CVE-2026-89945: ASoC: cs35l34: drain threaded IRQ before runtime susp=
end
      CVE-2026-89946: ASoC: cs35l33: drain threaded IRQ before runtime susp=
end
      CVE-2026-89947: clk: meson: align gxbb_32k_clk_sel number of parents =
with actual count
      CVE-2026-89948: batman-adv: bla: fix freeing of claims on meshif dele=
tion
      CVE-2026-89949: batman-adv: dat: avoid unaligned fault in IP extracti=
on
      CVE-2026-89950: batman-adv: mcast: linearize skbuff for packet genera=
tion
      CVE-2026-89951: batman-adv: fix stale receive device on merged fragme=
nts
      CVE-2026-89952: mtd: rawnand: validate ONFI extended parameter page s=
ections
      CVE-2026-89953: mtd: mtdoops: free page bitmap when the backing MTD i=
s removed
      CVE-2026-89954: mtd: afs: validate v2 image info bounds
      CVE-2026-89955: s390/vfio-ap: Fix NULL deref in status_show() during =
queue probe
      CVE-2026-89957: s390/vfio-ap: Fix hot-unplug skipped when last AP ada=
pter or domain removed
      CVE-2026-89958: s390/vfio-ap: Fix dereference matrix_mdev->kvm withou=
t checking for NULL
      CVE-2026-89959: s390/vfio-ap: Fix control domain removal in vfio_ap_m=
dev_cfg_remove
      CVE-2026-89960: s390/vfio-ap: fix stale pqap_hook pointer on error in=
 vfio_ap_mdev_set_kvm()
      CVE-2026-89961: powerpc/mm: fix wrong addr_pfn tracking in compound v=
memmap population
      CVE-2026-89962: powerpc/kexec_file: Prevent kexec range truncation
      CVE-2026-89963: powerpc/kexec_file: Fix null-ptr-def in extra size ca=
lculation
      CVE-2026-89964: parisc: eisa: Fix infinite loop when parsing invalid =
IRQ value
      CVE-2026-89965: nvdimm/btt: reject an arena whose nfree is below the =
lane count
      CVE-2026-89968: nvmet-tcp: reject unsolicited H2CData PDUs
      CVE-2026-89969: nvmet-tcp: fix out-of-bounds write when receiving an =
over-long PDU
      CVE-2026-89970: nvmet-auth: Synchronize timeout work during SQ teardo=
wn
      CVE-2026-89973: nvme-tcp: check the data direction of a C2HData PDU
      CVE-2026-89974: nvme-fc: fix double free of fabrics options when nvme=
_add_ctrl() fails
      CVE-2026-89975: nvme-fabrics: fix DHCHAP secret leak on parse failure
      CVE-2026-89979: ALSA: pcm: Fix race between non-atomic ops and trigge=
r-start
      CVE-2026-89980: ALSA: harmony: initialize locks before requesting IRQ
      CVE-2026-89982: i2c: mux: Fix channel node leak on adapter add failur=
e
      CVE-2026-89983: i2c: core: fix debugfs UAF on adapter removal
      CVE-2026-89984: perf/x86/intel: Fix kernel address leakages in LBR st=
ack
      CVE-2026-89986: mm/mempolicy: fix sleeping allocation in alloc_pages_=
bulk_weighted_interleave()
      CVE-2026-89988: kprobes: Protect kprobe_blacklist with RCU
      CVE-2026-89989: ima: Check for ERR_PTR from dentry_path() in validate=
_hash_algo()
      CVE-2026-89990: ceph: lock mutex in ceph_mds_check_access()
      CVE-2026-89992: cpuidle: dt_idle_genpd: kfree() the original name all=
ocation
      CVE-2026-89993: dmaengine: dw-edma: Initialize IRQ data before reques=
ting IRQs
      CVE-2026-89994: dmaengine: fsl-edma: tracing: no ptr dereference duri=
ng log output
      CVE-2026-89995: dma-direct: return struct page from dma_direct_alloc_=
from_pool()
      CVE-2026-89997: dm: fix resume-vs-remove race
      CVE-2026-89998: dm: fix race when loading and unloading a table
      CVE-2026-89999: HID: wacom: validate report length in wacom_intuos_pr=
o2_bt_irq
      CVE-2026-90000: HID: rmi: fix OOB access with undersized RMI reports
      CVE-2026-90001: HID: bpf: serialize device reference release in struc=
t_ops destroy path
      CVE-2026-90003: futex: Prevent rcuwait use-after-free during requeue =
PI
      CVE-2026-90007: scsi: pm8001: Use rollback index when freeing MSI-X v=
ectors
      CVE-2026-90011: scsi: target: iscsi: Reserve a terminator byte for th=
e login payload
      CVE-2026-90012: spi: Fix DMA mapping ownership on partial map failure
      CVE-2026-90015: xhci: fix lost bounce buffers on TDs spanning several=
 ring segments
      CVE-2026-90017: staging: rtl8723bs: fix OOB read in rtw_action_frame_=
parse()
      CVE-2026-90018: staging: rtl8723bs: fix OOB read / stack overflow in =
rtw_get_wps_attr()
      CVE-2026-90019: usb: gadget: fix null pointer dereference in usb_put_=
function_instance()
      CVE-2026-90020: USB: gadget: fix NULL pointer dereference in gadget_d=
ev_ioctl()
      CVE-2026-90021: usb: gadget: f_midi: initialize work in f_midi_alloc(=
)
      CVE-2026-90022: usb: gadget: f_midi2: fix use-after-free in string at=
tribute show path
      CVE-2026-90024: usb: gadget: midi2: Fix null-pointer dereference in f=
_midi2_free_ep_reqs
      CVE-2026-90025: usb: typec: ucsi: displayport: Fix OOB altmode array =
index
      CVE-2026-90026: usb: typec: qcom-pmic: cancel reset_work on stop
      CVE-2026-90027: usb: typec: qcom-pmic-typec: disable cc_debounce_dwor=
k on stop
      CVE-2026-90031: usb-storage: ene_ub6250: fix race between scan work a=
nd probe
      CVE-2026-90032: media: usbtv: keep device alive while ALSA card exist=
s
      CVE-2026-90033: ALSA: usb-audio: fix OOB write in snd_usbmidi_us122l_=
output()
      CVE-2026-90034: usb: image: mdc800: change kmalloc() to kzalloc()
      CVE-2026-90035: drm/amd/display: fix division by zero in get_estimate=
d_bw()
      CVE-2026-90048: fs/ntfs3: fix slab-out-of-bounds write in ni_create_a=
ttr_list()
      CVE-2026-90049: net: skbuff: don't skb_tx_error() the source skb in s=
kb_zerocopy()
      CVE-2026-90050: net/sched: fq: clamp quantum and initial_quantum in c=
hange path
      CVE-2026-90053: net/sched: sch_htb: limit htb_classify inner-class fi=
lter hops
      CVE-2026-90054: tcp: fix corruption of urgent data on multi-segment r=
etransmit
      CVE-2026-90055: usb: atm: usbatm: fix invalid ci_range initialization
      CVE-2026-90056: net: fec: only stop PTP if it was initialized
      CVE-2026-90057: slip: remove slip_hangup() to fix use-after-free in s=
lip_receive_buf()
      CVE-2026-90058: net/sched: bound qdisc_pkt_len to prevent qdisc soft =
lockup
      CVE-2026-90060: ALSA: control: Don't add invalid kcontrols to LED lay=
er
      CVE-2026-90062: netfilter: nf_tables: move hardware offload step afte=
r building the chain blob
      CVE-2026-90063: virtio-net: Ensure that TCP packets don't overflow gs=
o_segs
      CVE-2026-90065: net/smc: release the internal TCP sock on IPPROTO_SMC=
 socket creation failure
      CVE-2026-90066: samples/ftrace: Fix kthread_stop() on ERR_PTR in ftra=
ce-direct-multi-modify
      CVE-2026-90067: libceph: validate banner payload length
      CVE-2026-90068: ASoC: dapm: Fix off-by-one check on the second enum c=
hannel
      CVE-2026-90070: tpm: st33zp24: Return zero on status read failure
      CVE-2026-90071: net/sched: sch_teql: restore skb->dev on the slave fa=
ilure path
      CVE-2026-90072: net/sched: sfq: clamp quantum to avoid signed overflo=
w soft lockup
      CVE-2026-90073: net/sched: hhf: clamp quantum before hhf_change() to =
avoid overflow
      CVE-2026-90074: net/sched: fq_pie: clamp default quantum to avoid sig=
ned overflow
      CVE-2026-90075: net/sched: fq_codel: clamp default quantum and mtu
      CVE-2026-90076: net/sched: fq: add overflow bounds to quantum and ini=
tial quantum
      CVE-2026-90078: net/sched: act_skbmod: fix length calculations and av=
oid invalid header warnings
      CVE-2026-90081: net/rds: use wq_has_sleeper() in rds_cong_map_updated=
()
      CVE-2026-90085: octeontx2-af: fix NULL deref in NIX TM tree debugfs r=
ead path
      CVE-2026-90088: Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() =
to prevent infinite loop
      CVE-2026-90090: Bluetooth: btmtksdio: Fix out-of-bounds DMA read in t=
he TX path
      CVE-2026-90091: Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen(=
) vs. put_chan
      CVE-2026-90092: Bluetooth: L2CAP: reject accept queue add unless BT_L=
ISTEN
      CVE-2026-90101: bnxt_en: Fix call to hardware monitoring event handle=
r
      CVE-2026-90102: NFSv4/pnfs: key the data server cache on the NFS vers=
ion
      CVE-2026-90103: NFSv4.2: fix LAYOUTSTATS send buffer exhaustion
      CVE-2026-90107: net/smc: free pending qentry in smc_llc_flow_stop() b=
efore memset
      CVE-2026-90108: net/smc: free stashed qentry before overwrite in REQ_=
ADD_LINK to ADD_LINK transition
      CVE-2026-90109: net: sched: fix 32-bit backlog wrap in gred, bfifo an=
d plug enqueue
      CVE-2026-90110: inetpeer: randomize RB-tree node comparison using Sip=
Hash
      CVE-2026-90112: net: qlcnic: validate unified ROM sections before loa=
ding
      CVE-2026-90114: net: bridge: Reject descending VLAN tunnel ranges
      CVE-2026-90115: xsk: fix NULL pointer dereference in __xsk_rcv()
      CVE-2026-90119: ALSA: ice1712: Fix the card leak at probe error with =
the auto-cleanup
      CVE-2026-90122: clk: visconti: Make sure clk_init_data is fully initi=
alized
      CVE-2026-90124: irqchip/renesas-rzg2l: Fix loss of interrupt
      CVE-2026-90125: smb: client: fix request buffer leak in smb2_new_read=
_req()
      CVE-2026-90126: rtc: pcf8563: fix clock provider leak on unbind
      CVE-2026-90128: vdpa/mlx5: fix wrong list iterated in add_direct_chai=
n error path
      CVE-2026-90130: vdpa_sim: fix cleanup after worker creation failure
      CVE-2026-90135: net: add missing ref_tracker_dir_exit() to alloc_netd=
ev_mqs()
      CVE-2026-90137: platform/x86: hp-bioscfg: fix password encoding bound=
s check
      CVE-2026-90138: vsock: don't check the listener's sk_err in vsock_acc=
ept()
      CVE-2026-90139: fuse: check for NULL root inode in fuse_fill_super_su=
bmount
      CVE-2026-90140: cuse: wait for pending RCU callbacks on module exit
      CVE-2026-90141: ipvs: fix integer overflow in ftp helper port/address=
 parsing
      CVE-2026-90143: net: kcm: Hold RCU read lock while running BPF parser
      CVE-2026-90147: clk: devres: fix cleanup in devm_clk_get_optional_ena=
bled_with_rate()
      CVE-2026-90148: NFSv4: Fix incorrect argument passed to nfs4_delete_l=
ease() in nfs4_add_lease()
      CVE-2026-90150: pnfs/blocklayout: Fix device leaks on parse failure
      CVE-2026-90151: NFSv4: remove callback IDR entry on client allocation=
 failure
      CVE-2026-90152: smb/server: fix session leak in ksmbd_session_registe=
r()
      CVE-2026-90153: ksmbd: bound smb_check_perm_dacl() ACE walks by DACL =
size
      CVE-2026-90157: bpf: Reject negative optlen in cgroup getsockopt hook
      CVE-2026-90158: m68k: nfcon: Do not call console_is_registered() in n=
fcon_device()
      CVE-2026-90159: bpf: Disallow bpf_{g,s}etsockopt() in cgroup UNIX get=
name hooks
      CVE-2026-90160: lwt_bpf: Restore reserved headroom after xmit program
      CVE-2026-90165: smb/server: fix invalid pointer dereference in ksmbd_=
stop_durable_scavenger()
      CVE-2026-90166: smb/server: fix null-ptr-deref in ksmbd_ipc_tree_conn=
ect_request()
      CVE-2026-90169: ksmbd: free preauth sessions on connection teardown
      CVE-2026-90170: ksmbd: validate ipc response length before dereferenc=
ing its fields
      CVE-2026-90175: smb: server: fix leak of ksmbd_ipc_login_request_ext(=
) returned buffer
      CVE-2026-90176: ksmbd: Do not skip lock checks for single-byte ranges
      CVE-2026-90178: hwmon: (coretemp) Fix core_data leak on CPUs without =
PTS
      CVE-2026-90180: block: mtip32xx: synchronize ioctls with device remov=
al
      CVE-2026-90184: null_blk: serialize configfs attribute updates with d=
evice setup
      CVE-2026-90185: null_blk: serialize configfs attribute stores with th=
e lock
      CVE-2026-90186: null_blk: reject per-device queue resize for shared t=
ag set
      CVE-2026-90187: null_blk: free zones array on device power-off
      CVE-2026-90188: null_blk: free global tag_set on init error path
      CVE-2026-90189: null_blk: register configfs subsystem after creating =
default devices
      CVE-2026-90190: null_blk: use DEFINE_MUTEX for the file-scope mutex
      CVE-2026-90192: mailbox: qcom-cpucp: handle NULL data in send_data ca=
llback
      CVE-2026-90193: mailbox: qcom-cpucp: fix PREEMPT_RT self-deadlock in =
IRQ handler
      CVE-2026-90194: ACPI: scan: fix bus ID cleanup on device_add() failur=
es
      CVE-2026-90195: riscv, bpf: Fix missing sign-ext for signed 1-byte an=
d 2-byte kfunc args
      CVE-2026-90196: ASoC: SOF: validate topology volume range before allo=
cation
      CVE-2026-90198: ALSA: core: Fix use-after-free in snd_card_do_free()
      CVE-2026-90199: fs/ntfs3: reject out-of-range evcn in mi_enum_attr()
      CVE-2026-90200: fs/ntfs3: fix integer overflow in MFT cluster validat=
ion
      CVE-2026-90201: net: page_pool: fix UAF in __page_pool_release_netmem=
_dma on xa_cmpxchg race
      CVE-2026-90202: scsi: mpt3sas: Avoid freeing unallocated PCIe SGL buf=
fers
      CVE-2026-90203: Squashfs: check block offset is not negative
      CVE-2026-90207: ALSA: seq: midi: Serialize input teardown with event_=
input
      CVE-2026-90209: s390/debug: Fix deadlock during unregister
      CVE-2026-90211: bpf, s390: Clear fetch destination on faulting arena =
atomic
      CVE-2026-90213: firewire: core: fix memory leak in error path of buil=
d_tree()
      CVE-2026-90214: ASoC: xilinx: formatter_pcm: fix stream_data leak on =
open error
      CVE-2026-90215: mtd: ubi: Release device reference on busy detach
      CVE-2026-90216: ubi: Fix rollback for explicit UBI device numbers
      CVE-2026-90218: RDMA/cma: Fix WARNING in res_to_rt
      CVE-2026-90219: RDMA/cxgb4: Free debugfs on registration failure
      CVE-2026-90220: ALSA: seq: Don't leak the extension cell pointer in t=
he bounce payload
      CVE-2026-90221: nfc: nci: fix use of uninitialized memory in CORE_INI=
T_RSP parsing
      CVE-2026-90222: nfc: pn533: hold a reference to the request skb durin=
g send_frame
      CVE-2026-90223: nfc: llcp: bound SNL TLV parsing to the skb and add l=
ength checks
      CVE-2026-90224: nfc: nci: fix double completion race in nci_data_exch=
ange_complete
      CVE-2026-90225: nfc: llcp: read llcp_sock->local under the socket loc=
k in getsockopt
      CVE-2026-90226: nfc: llcp: avoid userspace overflow on invalid optlen
      CVE-2026-90227: nvme/ioctl: check SUBMIT_IO with nvme_cmd_allowed()
      CVE-2026-90228: nvmet: fix NULL pointer dereference in nvmet_execute_=
identify_ns_zns()
      CVE-2026-90229: nvme-apple: Destroy the admin queue on removal
      CVE-2026-90230: nvmet: fix heap out-of-bounds read in nvmet_auth_nego=
tiate()
      CVE-2026-90235: sunrpc: xprtsock: annotate shared socket callbacks wi=
th READ_ONCE/WRITE_ONCE
      CVE-2026-90241: iommu/vt-d: Tear down scalable-mode context on probe =
failure
      CVE-2026-90243: iommu/vt-d: Clear Present bit before tearing down cop=
ied context entry
      CVE-2026-90245: fbdev: kyro: Validate overlay viewport coordinates
      CVE-2026-90248: net/sched: cls_api: fix teardown of an adopted proto =
on insert-race loss
      CVE-2026-90249: iio: light: gp2ap002: Fix unbalanced runtime PM on re=
peated event writes
      CVE-2026-90250: bpf, cgroup: Fix storage null-ptr-deref after replaci=
ng prog
      CVE-2026-90251: Bluetooth: MSFT: validate evt_prefix_len against the =
response length
      CVE-2026-90253: Bluetooth: MGMT: free the mesh send cancel command wh=
en it is cancelled
      CVE-2026-90254: Bluetooth: hci_sync: free the advertising instance on=
 the failure and cancel paths
      CVE-2026-90255: Bluetooth: hci_conn: fix the SCO setup context lifeti=
me
      CVE-2026-90257: Bluetooth: virtio_bt: avoid OOB read of build info st=
ring
      CVE-2026-90262: btrfs: retry verity reads for not-uptodate Merkle fol=
ios
      CVE-2026-90274: coresight: etm4x: fix underflow for usage of (nrseqst=
ate - 1)
      CVE-2026-90275: md/raid1: don't set array_frozen in raid1_takeover()
      CVE-2026-90279: md/raid5: round bitmap stripes with sector division
      CVE-2026-90280: phy: qcom: qmp-usb: Fix possible NULL-deref on early =
runtime suspend
      CVE-2026-90281: phy: qcom: snps-femto-v2: Fix possible NULL-deref on =
early runtime suspend
      CVE-2026-90282: phy: qcom: qmp-usb-legacy: Fix possible NULL-deref on=
 early runtime suspend
      CVE-2026-90283: hugetlbfs: release subpool on fill_super failure
      CVE-2026-90284: firmware_loader: do not queue completed sysfs fallbac=
k requests
      CVE-2026-90285: scsi: qla2xxx: Remove redundant VPD flash read in sys=
fs read path
      CVE-2026-90286: drm/amdgpu/gfx6: Use PFP on the compute queues too
      CVE-2026-90287: phy: sunplus: fix error handling in sp_uphy_init()
      CVE-2026-90290: arm64: hibernate: Restore DAIF state on error
      CVE-2026-90291: module/dups: Fix use-after-free in kmod_dup_req lifet=
ime handling
      CVE-2026-90292: RDMA/siw: Fix use-after-free in siw_accept()
      CVE-2026-90293: IB/isert: post the full-feature receive buffers after=
 session registration
      CVE-2026-90294: IB/isert: delay the final Login Response until the se=
ssion is registered
      CVE-2026-90295: cpufreq: imx6q: fix out-of-bounds write when probed m=
ore than once
      CVE-2026-90296: cpufreq: imx6q: fix devres accumulation across driver=
 rebind
      CVE-2026-90297: drm/sun4i: crtc: Propagate layer initialization error
      CVE-2026-90298: drm/sun4i: tcon: Drop TCON TOP device reference
      CVE-2026-90302: ocfs2: synchronize heartbeat callbacks with o2net tea=
rdown
      CVE-2026-90303: ARM: 9485/1: mm: acquire mmap write lock around show_=
pte() for user faults
      CVE-2026-90306: ARM: 9481/2: breakpoint: CFI breakpoints only on dema=
nd
      CVE-2026-90307: RDMA/srp: fix heap information leak on a truncated SR=
P_CRED_REQ
      CVE-2026-90308: RDMA/erdma: Hold QP references for AE and CM processi=
ng
      CVE-2026-90309: RDMA/erdma: Hold CQ references when processing EQ eve=
nts
      CVE-2026-90313: bpf, cgroup: Fix invalid storage access after __cgrou=
p_bpf_attach failed
      CVE-2026-90314: remoteproc: fix OOB read via signed offset in rsc_tab=
le_for_each_entry()
      CVE-2026-90316: drm/omap: dsi: Do not copy isr table
      CVE-2026-90318: fat: release buffer head after rebuilding parent
      CVE-2026-90319: rapidio: clear mport->net when rio_add_net() fails
      CVE-2026-90322: ocfs2/cluster: keep heartbeat local node stable
      CVE-2026-90325: blk-cgroup: skip dying blkg in blkcg_activate_policy(=
)
      CVE-2026-90327: phonet: pep: do not write beyond optlen in getsockopt
      CVE-2026-90329: HID: synchronize input before cleaning up a failed pr=
obe
      CVE-2026-90334: tty: clear cdev pointer after cdev_add() failure
      CVE-2026-90341: firmware: coreboot: Validate table bounds
      CVE-2026-90344: wifi: mac80211: disconnect on CSA to channel 0
      CVE-2026-90348: wifi: ath10k: snoc: use memcpy_fromio() for MSA ramdu=
mp
      CVE-2026-90352: wifi: mt76: mt7915: release hif2 reference on probe I=
RQ failure
      CVE-2026-90353: wifi: mt76: mt7915: fix ext PHY use-after-free on reg=
ister error path
      CVE-2026-90354: wifi: mt76: mt7915: fix double hif2 init on the non-W=
ED path
      CVE-2026-90357: wifi: mt76: mt7915: unlink TWT flow if the MCU reject=
s the agreement
      CVE-2026-90358: bpf, x86: Fix trampoline stack size for 128-bit argum=
ents
      CVE-2026-90360: regulator: core: use system_freezable_wq for init com=
plete work
      CVE-2026-90361: wifi: ath11k: fix leak in ath11k_service_ready_ext_ev=
ent()
      CVE-2026-90362: drm/msm/dsi: Drop dev_pm_opp_set_rate(0)
      CVE-2026-90364: ACPI: processor: Unregister cpufreq notifier on init =
failure
      CVE-2026-90366: wifi: mt76: mt7996: reserve space for the CSA-abort c=
ountdown TLV
      CVE-2026-90368: wifi: mt76: mt7915: unwind state on add_interface fai=
lure
      CVE-2026-90370: wifi: mt76: mt7996: bound TLV walk in mt7996_mcu_get_=
chip_config
      CVE-2026-90372: wifi: mt76: mt7915: avoid nss underflow in mt7915_mcu=
_get_sta_nss
      CVE-2026-90373: wifi: mt76: mt7915: clear wcid mask under mutex after=
 RCU pointer clear
      CVE-2026-90374: wifi: mt76: mt7996: validate RX band_idx before deref=
erencing phys[]
      CVE-2026-90375: wifi: mt76: fix non-AQL packet accounting for MLO sta=
tions
      CVE-2026-90378: wifi: mt76: mt792x: Fix memory leak in SDIO TX path
      CVE-2026-90380: wifi: mt76: mt792x: fix use-after-free in mt76_rx_pol=
l_complete
      CVE-2026-90382: wifi: mt76: mt76x02: do not WARN on invalid rx descri=
ptor length
      CVE-2026-90383: misc: sgi-gru: remove interrupt-context page-table wa=
lks
      CVE-2026-90385: md/raid1: create serial pool adding rdev to array wit=
h serialize_policy=3D1
      CVE-2026-90386: i3c: dw: avoid shift-out-of-bounds when DAA assigns n=
o devices
      CVE-2026-90387: swiotlb: Preserve allocation virtual address for dyna=
mic pools
      CVE-2026-90388: iommu/dma: Check atomic pool allocation result direct=
ly
      CVE-2026-90389: md: scope memalloc_noio to allocation critical sectio=
ns
      CVE-2026-90390: md/bitmap: resume array on backlog_store() error path
      CVE-2026-90391: lib/test_hmm: fail dmirror_fault() when the mirrored =
mm is gone
      CVE-2026-90392: bpf: Fix potential UAF when reading bpf link info
      CVE-2026-90393: bpf: Fix potential UAF in bpf_netns_link_update_prog
      CVE-2026-90394: power: supply: sc2731_charger: cancel work on remove
      CVE-2026-90395: power: supply: isp1704_charger: cancel work on remove
      CVE-2026-90397: firmware: qcom: scm: Fix NULL dereference in IRQ hand=
ler before __scm is published
      CVE-2026-90398: wifi: ath11k: fix stride mismatch in mac_phy_caps_par=
se()
      CVE-2026-90399: wifi: ath12k: fix stride mismatch in mac_phy_caps_par=
se()
      CVE-2026-90400: md: recheck spare changes before starting sync
      CVE-2026-90402: bus: mhi: host: Fix controller cleanup on EDL sysfs f=
ailure
      CVE-2026-90403: wifi: rtlwifi: pci: fix error path in rtl_pci_probe()
      CVE-2026-90404: platform/chrome: cros_ec_debugfs: Unregister panic no=
tifier
      CVE-2026-90407: wifi: ath11k: fix overreads in ath11k_wmi_process_csa=
_switch_count_event()
      CVE-2026-90410: spi: davinci: switch to managed controller allocation
      CVE-2026-90411: nvme-fc: unmap cmd_iu DMA on rsp_iu mapping failure i=
n init_request
      CVE-2026-90413: IB/isert: reject login PDUs declaring more data than =
was received
      CVE-2026-90414: IB/isert: reject PDUs declaring more data than was re=
ceived
      CVE-2026-90415: RDMA/cxgb4: free STAG index when TPT entry write fail=
s
      CVE-2026-90416: RDMA/mlx5: Fix stack out-of-bounds read in cc_params =
debugfs
      CVE-2026-90418: nilfs2: fix BUG in nilfs_copy_dirty_pages() on dirty =
state mismatch
      CVE-2026-90419: nilfs2: prevent out-of-bounds read in super root bloc=
k parsing
      CVE-2026-90420: nilfs2: fix infinite loop in nilfs_clean_segments()
      CVE-2026-90426: iommu/tegra241-cmdqv: Free the error IRQ before teari=
ng down VINTFs
      CVE-2026-90428: iommu/tegra241-cmdqv: Don't run the error ISR before =
probe sets up vintfs
      CVE-2026-90431: remoteproc: Prevent crash handling to race with rproc=
_del()
      CVE-2026-90433: spi: oc-tiny: switch to managed controller allocation
      CVE-2026-90434: isofs: release zisofs block pointer buffer head
      CVE-2026-90435: RDMA/mlx5: Fix integer overflow of user QP buffer siz=
e
      CVE-2026-92476: crypto: keembay - Initialize completion before reques=
ting IRQ
      CVE-2026-92477: scsi: ufs: debugfs: Reserve space for a string termin=
ator
      CVE-2026-92481: pinctrl: mediatek: free EINT resources on unbind
      CVE-2026-92484: cxl/region: Fix use-after-free in find_pos_and_ways()=
 error path
      CVE-2026-92488: RDMA/erdma: complete object teardown when the destroy=
 command fails
      CVE-2026-92489: xfrm: Fix skb double-free in xfrm_dev_direct_output()
      CVE-2026-92490: firmware: arm_scmi: Unrequest devices if driver regis=
tration fails
      CVE-2026-92491: firmware: arm_scmi: Roll back partial protocol table =
registration
      CVE-2026-92494: ext4: fix buffer_head leak in ext4_init_orphan_info
      CVE-2026-92495: RDMA/bnxt_re: Clear VM_MAYWRITE on DBR/toggle page mm=
ap
      CVE-2026-92496: wifi: ath11k: Avoid buffer overread in ath11k_wmi_tlv=
_op_rx()
      CVE-2026-92497: wifi: ath12k: Avoid buffer overread in ath12k_wmi_op_=
rx()
      CVE-2026-92498: wifi: ath6kl: avoid buffer overreads in WMI event han=
dlers
      CVE-2026-92501: ext4: drain in-flight DIO before buffered write fallb=
ack
      CVE-2026-92502: ext4: clear stale xarray tags on folios skipped durin=
g writeback
      CVE-2026-92504: thermal: intel: int3400: clean up ODVP on probe failu=
res
      CVE-2026-92506: firmware: arm_scmi: Fix requested device removal race
      CVE-2026-92507: RDMA/core: Fix potential use after free in ib_dealloc=
_pd_user()
      CVE-2026-92508: RDMA/core: Fix potential use after free in ib_free_cq=
()
      CVE-2026-92509: RDMA/core: Fix potential use after free in counter_re=
lease()
      CVE-2026-92510: RDMA/core: Fix potential use after free in ib_destroy=
_srq_user()
      CVE-2026-92511: RDMA/core: Fix potential use after free in ib_destroy=
_cq_user()
      CVE-2026-92512: RDMA/core: Fix use after free in ib_query_qp()
      CVE-2026-92514: RDMA/erdma: Fix CEQ tasklet use-after-free on removal
      CVE-2026-92515: bpf: Preserve unique-field state across nested struct=
s
      CVE-2026-92519: riscv, bpf: Fix memory leak in bpf_jit_free
      CVE-2026-92521: ACPI: PCI: Clear driver_data on all paths that free t=
he acpi_pci_root
      CVE-2026-92522: ACPI: processor: validate MADT IOAPIC entry bounds
      CVE-2026-92523: RDMA/nldev: validate dynamic counter attribute length
      CVE-2026-92524: irqchip/gic-v3-its: Prevent leak in its_vpe_irq_domai=
n_alloc()
      CVE-2026-92525: RDMA/rxe: Validate num_sge/cur_sge before indexing wq=
e->dma.sge[]
      CVE-2026-93037: RDMA/hfi1: Propagate sdma_txinit_ahg() errors
      CVE-2026-93039: ASoC: meson: Keep link pointers valid on realloc fail=
ure
      CVE-2026-93040: dmaengine: dw-edma: Serialize channel state checks
      CVE-2026-93041: dmaengine: dw-edma: Serialize abort state updates
      CVE-2026-93042: dmaengine: dw-edma: Terminate all descriptors without=
 callbacks
      CVE-2026-93045: bpf: Reject arena frees below the arena base
      CVE-2026-93046: software node: Fix software_node_get_reference_args()=
 with index -1
      CVE-2026-93048: mtd: part: reject MTDPART_OFS_RETAIN in mtd_add_parti=
tion()
      CVE-2026-93049: mtd: mtdswap: Avoid freeing registered blktrans devic=
e twice
      CVE-2026-93050: ipack: ipoctal: fix UAF, null-ptr-deref, and use-afte=
r-free in cleanup on remove
      CVE-2026-93051: misc: ad525x_dpot: use driver core groups for sysfs f=
iles
      CVE-2026-93052: misc: bcm-vk: Use acquire/release for msgq_inited
      CVE-2026-93053: speakup: keyhelp: guard letter_offsets possible out-o=
f-range indexing
      CVE-2026-93054: uio: Fix stale info pointer in failed registration pa=
th
      CVE-2026-93055: UDF symlink pathComponent header OOB read
      CVE-2026-93056: usb: gadget: f_uac1_legacy: remove broken string conf=
igfs attributes
      CVE-2026-93061: gpu: host1x: Avoid stack over-read in debug output he=
lpers
      CVE-2026-93062: wifi: iwlwifi: guard against division by zero in iwl_=
dbg_tlv_alloc_fragments
      CVE-2026-93063: wifi: iwlwifi: mei: check SAP message length before r=
eading it
      CVE-2026-93064: wifi: iwlwifi: mvm: fix off-by-one in TXF key sanitis=
er
      CVE-2026-93065: wifi: iwlwifi: fix counter type in iwl_fwrt_dump_erro=
r_logs
      CVE-2026-93067: drm/bridge: tc358767: clamp the reported AUX read siz=
e to the request
      CVE-2026-93070: media: ipu6: Do not free aux device pdata after init
      CVE-2026-93071: media: bcm2835-unicam: Fix asc leaked in error/remove=
 path
      CVE-2026-93072: irqchip/renesas-irqc: Fix generic interrupt chip leak=
 on remove
      CVE-2026-93073: dax: read holder_ops once in dax_holder_notify_failur=
e()
      CVE-2026-93082: firmware: arm_scmi: Unwind P2A receiver mailbox setup=
 failure
      CVE-2026-93083: firmware: arm_scmi: Unwind TX receiver mailbox setup =
failure
      CVE-2026-93084: firmware: arm_scmi: Drop handle on protocol bind fail=
ures
      CVE-2026-93085: firmware: arm_scmi: Reject out of range DT protocol I=
Ds
      CVE-2026-93086: firmware: arm_scmi: Avoid IDR updates while cleaning =
channels
      CVE-2026-93089: firmware: arm_scmi: Free transport channel on IDR fai=
lure
      CVE-2026-93090: firmware: arm_scmi: Clean up channels on setup failur=
e
      CVE-2026-93091: firmware: arm_scmi: Quiesce notifications before tear=
down
      CVE-2026-93092: firmware: arm_scmi: Unregister device notifier before=
 IDR teardown
      CVE-2026-93093: firmware: arm_scmi: Publish channel state before call=
backs
      CVE-2026-93095: hfsplus: validate thread record before delete key reb=
uild
      CVE-2026-93097: cxl/mbox: Break poison list loop on an empty payload
      CVE-2026-93098: rpmsg: glink: fix deadlock in endpoint destroy during=
 driver detach
      CVE-2026-93101: media: v4l2-async: Unregister sub-device if asc_list =
is empty
      CVE-2026-93102: RDMA/hfi1: Free RX data on late probe failure
      CVE-2026-93103: RDMA/hfi1: Preserve unit 0 on allocation failure
      CVE-2026-93107: RDMA/rxe: Avoid reprocessing the current packet after=
 the QP enters the error state
      CVE-2026-93108: RDMA/ipoib: Drain RCU callbacks during module teardow=
n
      CVE-2026-93109: RDMA/mlx5: Drain RCU callbacks during module teardown
      CVE-2026-93110: RDMA/core: Wait for RCU callbacks before unloading ib=
_core
      CVE-2026-93113: clk: qcom: camcc-sc8280xp: unregister CAMCC_GDSC_CLK
      CVE-2026-93114: platform/surface: acpi-notify: Check ACPI companion b=
efore use
      CVE-2026-93115: platform/mellanox: mlxbf-pmc: Check ACPI_COMPANION() =
against NULL
      CVE-2026-93117: usb: fix UAF when probe runs concurrent to dyn ID rem=
oval
      CVE-2026-93118: usb: gadget: aspeed_udc: check endpoint DMA allocatio=
n
      CVE-2026-93119: usb: ljca: bound bank_num in ljca_enumerate_gpio()
      CVE-2026-93120: usb: gadget: configfs: fix out-of-bounds read of qw_s=
ign
      CVE-2026-93121: usb: gadget: f_fs: Fix fence cleanup in ffs_dmabuf_tr=
ansfer() error paths
      CVE-2026-93123: serial: qcom-geni: do not advance stale DMA completio=
ns
      CVE-2026-93126: remoteproc: qcom_q6v5_adsp: Fix reference leak for de=
vice node
      CVE-2026-93128: platform/x86: lg-laptop: Fix LED resource handling
      CVE-2026-93130: platform/x86: dell-wmi-base: Fix resource leak on mod=
ule load failure
      CVE-2026-93131: platform/x86: dell-privacy: Fix race condition
      CVE-2026-93132: ACPI: RISC-V: Fix riscv_acpi_add_prt_dep() loop handl=
ing
      CVE-2026-93133: ACPI: RISC-V: Check acpi_get_handle() status in riscv=
_acpi_add_prt_dep()
      CVE-2026-93134: printk: Fix possible console use-after-free
      CVE-2026-93136: bus: mhi: ep: Fix device refcount leak in the error p=
ath of MHI device creation
      CVE-2026-93137: bpf: Fix use-after-free on mm_struct in bpf_find_vma(=
)
      CVE-2026-93138: bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux
      CVE-2026-93140: udf: Mark LVID buffer as uptodate before marking it d=
irty
      CVE-2026-93141: usb: gadget: r8a66597: avoid double free of ep0_req i=
n probe error path
      CVE-2026-93142: thermal/drivers/rcar: Fix error checking in probe()
      CVE-2026-93145: clk: qcom: gdsc: tear down per-domain genpds in gdsc_=
unregister()
      CVE-2026-93149: wifi: mac80211_hwsim: avoid NULL skb in stop queue dr=
ain
      CVE-2026-93150: cgroup/cpuset: Make nr_deadline_tasks an atomic_t
      CVE-2026-93151: nvmet-rdma: fix response resource leak on queue teard=
own
      CVE-2026-93152: nvme-apple: Use acquire/release for queue enabled sta=
te
      CVE-2026-93155: crypto: keembay - Fix AEAD unregister count in error =
path
      CVE-2026-93156: crypto: rk3288 - fail ahash requests on HASH idle tim=
eout
      CVE-2026-93158: crypto: sa2ul - stop probe if context pool creation f=
ails
      CVE-2026-93159: crypto: atmel-sha204a - fix heap info leak on I2C tra=
nsfer failure
      CVE-2026-93160: crypto: atmel-ecc - reject hardware ECDH without a pu=
blic key
      CVE-2026-93161: crypto: qat - clear AES key schedule from stack
      CVE-2026-93162: crypto: qat - cancel work on re-enable SR-IOV timeout
      CVE-2026-93163: hwrng: core - fix rng list on registration error
      CVE-2026-93165: platform/chrome: sensorhub: Fix memory overread in ri=
ng handler
      CVE-2026-93167: csky: Fix a4/a5 restoration in syscall trace path
      CVE-2026-93170: dmaengine: xilinx_dma: Fix channel idle state managem=
ent in AXIDMA and MCDMA interrupt handlers
      CVE-2026-93172: mm/mm_init: handle alloc_percpu failure in free_area_=
init_core_hotplug
      CVE-2026-93173: bpf,lsm: Drop bpf_prog_free from sleepable_lsm_hooks
      CVE-2026-93174: bpf: Copy per-CPU map value padding in copy_map_value=
_long()
      CVE-2026-93177: drm/amdgpu/pm/powerplay: bounds-check voltage index i=
n Vega10 lookup
      CVE-2026-93178: drm/amdgpu/pm/powerplay: bounds-check voltage index i=
n SMU7 lookup
      CVE-2026-93182: sched/fair: Fix overflow in update_tg_cfs_runnable()
      CVE-2026-93183: drm/lima: call drm_mm_init() with a valid allocation =
range
      CVE-2026-93184: ASoC: fsl_audmix: rework runtime PM handling in probe
      CVE-2026-93185: ASoC: rt700-sdw: always drain jack work on remove
      CVE-2026-93186: cxl/mbox: Clamp mailbox output allocation to the payl=
oad size
      CVE-2026-93188: HID: roccat: bound device-supplied profile index
      CVE-2026-93189: HID: core: quiesce input in hid_hw_stop() to prevent =
use-after-free
      CVE-2026-93190: platform/chrome: cros_ec_typec: Reject out-of-bounds =
PD cap count
      CVE-2026-93191: smack: fix incorrect task context in smack_msg_queue_=
msgrcv
      CVE-2026-93192: drm/v3d: Clear queue->active_job when v3d_fence_creat=
e() fails
      CVE-2026-93203: batman-adv: bla: avoid CRC corruption due to parallel=
 claim add
      CVE-2026-93204: batman-adv: dat: atomically update mac addresses
      CVE-2025-40210: Revert "NFSD: Remove the cap on number of operations =
per NFSv4 COMPOUND"
      CVE-2026-68286: drop_monitor: perform u64_stats updates under IRQ-dis=
abled section
      CVE-2026-68287: drop_monitor: fix size calculations for 64-bit attrib=
utes
      CVE-2026-68288: net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLO=
AD
      CVE-2026-68289: tipc: fix integer overflow in tipc_recvmsg() and tipc=
_recvstream()
      CVE-2026-68303: drm/vc4: hvs/v3d: Fix null dereference in unbind
      CVE-2026-68337: bpf: Reject redirect helpers without a bpf_net_contex=
t
      CVE-2026-72334: Bluetooth: ISO: fix malformed ISO_END/CONT handling
      CVE-2026-72402: bpf: Mask pseudo pointer values in verifier logs
      CVE-2026-72413: sctp: fix err_chunk memory leaks in INIT handling
      CVE-2026-72438: md/raid10: fix writes_pending and barrier reference l=
eaks on discard failures
      CVE-2026-72485: coresight: platform: defer connection counter increme=
nt until alloc succeeds
      CVE-2026-72496: RDMA/bnxt_re: Proper rollback if the ioremap fails
      CVE-2026-74258: bpf: Guard __get_user acesss with access_ok for uprob=
e_multi data
      CVE-2026-74289: ipv4: fib: Don't dump dying fib_info in fib_leaf_noti=
fy().
      CVE-2026-74291: ASoC: topology: Check PCM and DAI name strings before=
 use
      CVE-2026-74294: ASoC: meson: aiu: Validate written enum values
      CVE-2026-74496: fou: Fix use-after-free in fou_create()
      CVE-2026-74521: ksmbd: use memcmp() to compare ClientGUIDs
      CVE-2026-74735: l2tp: fix tunnel and session refcount leak on seq_fil=
e release
      CVE-2026-80521: af_unix: Unlink scc_entry in unix_del_edge().
      CVE-2026-80836: crypto: virtio - bound the akcipher result length
      CVE-2026-80841: net/packet: defer vmalloc TX_RING free until skbs fin=
ish
      CVE-2026-80847: tcp: clamp route advmss to TCP_MIN_MSS
      CVE-2026-80860: fuse: fix race between interrupt and resend
      CVE-2026-80861: usb: xhci: bail out of setup if the controller is ina=
ccessible
      CVE-2026-80925: vlan: fix skb_under_panic and races when toggling HW =
VLAN offload
      CVE-2026-80926: ksmbd: fix use-after-free in oplock break notificatio=
n
      CVE-2026-80945: crypto: iaa - unmap dst before software fallback on d=
ecompress
      CVE-2026-89492: ocfs2: validate directory-index entry counts when rea=
ding metadata
      CVE-2026-89535: svcrdma: Reorder rpcrdma_rn_unregister before rdma_de=
stroy_id
      CVE-2026-89543: sunrpc: fix use-after-free in __rpc_clnt_handle_event=
 and __rpc_clnt_remove_pipedir
      CVE-2026-89544: SUNRPC: fix gssx_dec_option_array error path bugs
      CVE-2026-89545: sunrpc: defer rq_argp and rq_resp free until after RC=
U grace period
      CVE-2026-89561: ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_s=
rh_rcv()
      CVE-2026-89564: ip: orphan prefetched skbs before multicast forwardin=
g
      CVE-2026-89572: cpufreq: apple-soc: Fix OPP table cleanup
      CVE-2026-89589: acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work =
locks
      CVE-2026-89602: erofs: skip sufficiently large global buffers when re=
sizing
      CVE-2026-89622: HID: mcp2221: clear rxbuf after I2C/SMBus transfer co=
mpletes
      CVE-2026-89624: HID: universal-pidff: stop the device when force-feed=
back init fails
      CVE-2026-89625: HID: sony: fix UAF of ghl_poke_timer / ghl_urb at dri=
ver unbind
      CVE-2026-89644: btrfs: fix extent map leak in NOCOW direct I/O write
      CVE-2026-89659: NFSD: Prevent client use-after-free during delegation=
 revoke
      CVE-2026-89660: NFSD: Prevent client use-after-free during admin stat=
e revocation
      CVE-2026-89667: nfsd: close shrinker/GC/fsnotify vs per-net shutdown =
race in filecache
      CVE-2026-89676: nfsd: fix stale s2s_cp_stateids IDR entry for async C=
OPY
      CVE-2026-89685: nfsd: fix clock domain mismatch in clients_still_recl=
aiming()
      CVE-2026-89693: nfsd: check nfsd4_acl_to_attr() return value in nfsd4=
_create()
      CVE-2026-89698: nfsd: widen nfsd_genl_rqstp address fields to sockadd=
r_storage
      CVE-2026-89700: nfsd: validate sockaddr length per family in listener=
_set
      CVE-2026-89708: nfsd: RCU-protect cl_cb_session to fix use-after-free=
 on session teardown
      CVE-2026-89717: zram: set default primary compressor in zram_destroy_=
comps()
      CVE-2026-89718: zram: fix out-of-bounds access in writeback_store()
      CVE-2026-89719: zram: fix out-of-bounds access in read_block_state()
      CVE-2026-89731: cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER=
 register read
      CVE-2026-89755: mm/migrate_device: clear stale mapping after freeing =
swapcache
      CVE-2026-89763: KEYS: trusted: Fix TPM teardown ordering
      CVE-2026-89792: ksmbd: prevent out-of-bounds reads in share config re=
sponses
      CVE-2026-89796: mm/damon/core: avoid infinite kdamond_merge_regions()=
 internal loop
      CVE-2026-89798: rpcrdma: arm rn_done before publishing the notificati=
on
      CVE-2026-89799: bpf: Disable preemption in bpf_get_stackid
      CVE-2026-90036: NFSD: Prevent client use-after-free during blocked-lo=
ck reaping
      CVE-2026-90037: NFSD: Prevent client use-after-free during close_lru =
reaping
      CVE-2026-90039: NFSD: Guard admin state-revocation walks with NFSD_NE=
T_UP
      CVE-2026-90041: HID: sony: clean up device list on probe failure
      CVE-2026-90042: ceph: properly decrypt filenames in vmalloc() buffers
      CVE-2026-90044: usb: gadget: f_fs: Fix Use-After-Free in AIO error pa=
th
      CVE-2026-90045: USB: gadget: ffs: fix mm lifetime handling
      CVE-2026-90304: ARM: 9484/1: enable interrupts when unhandled user fa=
ults are triggered
      CVE-2026-90430: iommu/tegra241-cmdqv: Publish an LVCMDQ only after it=
 is fully initialized
    added commits:
      CIP: Bump version suffix to -cip32 after merge from stable
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add alias for on-SoC RTC
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RTC
      arm64: dts: renesas: r9a09g056: Add RTC node
      clk: renesas: r9a09g056: Add clock and reset entries for RTC
      dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2N support
      rtc: renesas-rtca3: Factor out year decoding helper
      rtc: renesas-rtca3: Fix typo in rtca3_ppb_per_cycle documentation
      rtc: renesas-rtca3: Fix incorrect error message for reset assert
      rtc: renesas-rtca3: Check RADJ poll result during initial setup
      rtc: renesas-rtca3: Fix PIE clear polling condition in alarm setup er=
ror path
      pinctrl: renesas: rzg2l: Populate struct gpio_chip::set_config
      arm64: dts: renesas: r9a09g057: Add DMA support for RSPI channels
      arm64: dts: renesas: r9a09g056: Add DMA support for RSPI channels
      can: rcar_canfd: change the initializing flow for clocks and resets
      arm64: dts: renesas: r9a09g087: Add DMAC support
      arm64: dts: renesas: r9a09g077: Add DMAC support
      dmaengine: sh: rz_dmac: add RZ/{T2H,N2H} support
      dmaengine: sh: rz_dmac: make register_dma_req() chip-specific
      dmaengine: sh: rz_dmac: make error interrupt optional
      dmaengine: sh: rz-dmac: fix device leak on probe failure
      dmaengine: sh: rz-dmac: add r7s72100 support
      dt-bindings: dma: renesas,rz-dmac: document RZ/{T2H,N2H}

Best regards,
  Nobuhiro


