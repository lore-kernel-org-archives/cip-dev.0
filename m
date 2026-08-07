Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9905CC5AC7C
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 08:24:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37928.1786091095469482654
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Aug 2026 01:24:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=B+CXn5Tt;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1786091083;x=1787300683;bh=
	zpnCzjggJG2WOje8waZcq/2dOng/27D0eCVFkGbJcRQ=;b=B+CXn5TtSgQYFZc4u3HKJASKDnj3PH
	FTP6Y47RHrHvhGST2IfQvBLJheOWGQF20T8UjZJTFeGXt80qf+xfljiE6vFLAnFlyTX6po4MCvgEB
	NUN/qnPhuKvbzhK4GN/UVJz61gTEXOBRjoWj5F9Ko4se71vIW+HYokpi8NKzJyZx2vPUpik1jw59U
	yCpB4zKFKYMeJmChdjn7y9r/omY3iXRlLDatqBXJuc/sDsIRR2HVqqUP9g7PtG8dCeemB3CYZWXO4
	z4LRGoklVFIT9hT2WdRRAoAFMo/Tld2ngVkF6zN1XTLNTRdG1usioPW40ZHTyYqV8s7p2nvTlrVvj
	hZsg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6778OgTp2979027; Fri, 7 Aug 2026 17:24:42 +0900
X-Iguazu-Qid: 2rWhJyGICFi1h81wNo
X-Iguazu-QSIG: v=2; s=1; t=1786091082; q=2rWhJyGICFi1h81wNo; m=36mL7WLnrb+rO8WAfqNSuUl39WZF7AxGqrqYpL7mu3A=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hGcdP0KfMz1xng; Fri,  7 Aug 2026 17:24:41 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0SU6NZPB8VXC+LZ8duDzvS6heZYFqKy4wT4uUOzRRpp4WMe134C5J4dNWbQFluJaCs4Smc+1fcMDFNUkwUqX/hFdkQtpirVFFHS7U3ejgMvkveHnl7oV0eK8vqCOxPdYpBUZIFyuuS2bC2Y9M783KCHL04Ai1smarfZ21IYfTtFb6o60r6RVxz2FYcygbmKgasEX6kZS/+UKQcSCWtabjadMRDeT+u6DYjVafxPXTPO65jOhbgvEoRjwH19rYI8ECqvv+R50AskiSxSHHLLYrfJSvGxtwNb2836qTN8sXYrrsSMLMgGwbdidQtfszvezuGBR74eNIgxe+euB8Vw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sh6PltA2bCyVyBYfeoHEQzEzKNW5LmpkawkmhFHZnA4=;
 b=YEqKJbO7rVr4X0KJBkYnnaxjEUml4LfJAw3QdBHDTBKyEKla4kqv6CCiUri+sjyIAGMZIHwgEDwvqPmQt5796upEubzoLiR14zPwxk4JGl3Y21ZHolheo7TjDWelBurtItU622KHxIMyx6ZyXSH8lr+OCm50GQKXKQNqBwzq9awS/tFk+FtEmtUIX8/MSq5W+3NewaJVIUrJjllWOSGphJab/WoqNWTbFgDLUI8jHuma+gEaDvEeE0yCnYrNF1biI4ZdaTvxtfsIQlASAg2Q11T+P+3O9X0wJToW/rcHgMGJQ1yXZAzsbJ02zoCyw9ESL7mnQTsdjCAlR7rqmJYZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.12.101-cip29
Thread-Topic: [ANNOUNCE] Release v6.12.101-cip29
Thread-Index: Ad0mJlFs970/NwDtTgywLPlv/eZRBg==
Date: Fri, 7 Aug 2026 08:24:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818797967D94CCFB5E8C934CDD12@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYVPR01MB10862:EE_
x-ms-office365-filtering-correlation-id: 601d5a90-3660-48d7-dcdf-08def45d511f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|56012099006|11063799006|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info: 
 PKrHyIbik1RAHo+fe5jpdZ4KItyAgLh8zxe6uZk/n/nu6ZAundBRWKd1a89O1qYr7W/A6nzY7LBj1UXRrtvM+bmUNqInVVoU/pS8iYQF47f3FYlUSP82ByOeCNx7qv0F3chkQKqaf96DzjzOlHesk8RNrqy1v7lxb5Y8d1t5GUK98JdGGNafduMMWcPSIVX7X2LV831ACQMzeUAm51tKbD0KnHqd98XTvzJ8Keln2VK533fGmAWrndqN63SqbQIL9no8dfrC+akS03cN/0QN7lV34NFoWXRrFFTK7Z3ROSlnPBKQuC88Y5Ar53x0DR7EYCcEaILyLJmcDRaPQpTemnYB9CVp8LjEcjjbUc6GJbTdoL2bEbNu0DHFq4BT00iPD424Wnqo3Cm1NdOBigmk6opOHzJ+UfvnFEbOSYPoef4b8g8p8AvHeb+FHnvLAMFFytZI346GNFG9FO/qZBnlcrmuWvG8pReHT4Cj7oO65dj6WB6oCZoeSIlq8MeA4r5k8SA21qruYTRRrqfNaIAbUknFCjn+ut7E6wFKfunA1JS+eubnlnYWbQwYpja+olLmcNT9I56hhW+BGhrIdfMKqeusSzjDMkGx3uu/yh8vpfv93AE3iOYbY36q1jLypezuvP0vG3B83A7xzTFUpood+jZbl9C4kGGY1bTzVU8J3EPynV3Rn3Ck0xsr48zOmbR+TlRH3JnvoWbpLISD4pt5ULnoDWC9c+QK5lU0F94aIX0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(56012099006)(11063799006)(38070700021)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dStXcHpjL1FodzludFBZQTdUNmY3S0tJeEhuL0tWZmNhSmEvNWJHdTMz?=
 =?iso-2022-jp?B?RUJ4b0d5WlpGQURBcy9qYjBOTmRWSlJuSlNkRnZGSXlBWGtpZ2c1Wnlz?=
 =?iso-2022-jp?B?NWlQUGl1ZmhVUGxwYTVWbG9paEZ2d1N1YkwveUFQRlY3d0h1NmdrN3BN?=
 =?iso-2022-jp?B?bU5QUWJYQ3pFbmZQTzhEbXJCTXJhSncxY2RDTXBXTlY4dUpjak5RR1c2?=
 =?iso-2022-jp?B?a1NpTzhraXJQbjdkRk9aMXBVYWExcTkvTUVGSllKaXE4WEJrR2xBcTB3?=
 =?iso-2022-jp?B?dTgvSVhxOHZKOGpVSXhMelUyK3JZQUx3RktkSXZqU2I3Mmw2NE9XK0dy?=
 =?iso-2022-jp?B?OU9pM1hZM29aNEcwRCtnaXRkYWJTZUFxQ2NnTVVkVDNpTkZsajg1cnFa?=
 =?iso-2022-jp?B?YWd0aU9kMnJCc0hqaVdiUFFwTnkvMzdnSzJGRkRETHRERmRrTkZkcnJ2?=
 =?iso-2022-jp?B?WG9pdm1tY0R5anBUb3JwYVNaRkw5OFlIdzlyKzVNT0xzeXlpVitUcG0v?=
 =?iso-2022-jp?B?cmQwUVBPRzVyaCtuaFFnNngvSHArQmlONS81NHltcDlRZFdFcndnZmFN?=
 =?iso-2022-jp?B?TGZVRGJxOG1TejNHaElBSk9XU09zOFN0R0dEakxiSzFXWTBFNEdZRHNo?=
 =?iso-2022-jp?B?UndwUVR4R1VXUFRiWGFaTmpCMENCcWtLQkJwVzI4U3M2MkQ0VDVWZXFV?=
 =?iso-2022-jp?B?ZW9LNVZMLzBRY2ZQMzlic21jZGI0SUNoMWpQa2Q4cDNBckdiVWxFRkVO?=
 =?iso-2022-jp?B?d2EvempZSXpIeUpBWnlKbTMrT3l5akljRWdya2VqM1FLdTYvclBqR2cz?=
 =?iso-2022-jp?B?TWNRODdqTVR2d3Q3SzdybXQvR0JEeHFlK25ldU1zK2R1SU5KTkR3c2w2?=
 =?iso-2022-jp?B?UHhZck5ERUZZYitCdkdubjZQU2pyVG9uRmJDWmFUd0U2enRjNEJHWU9u?=
 =?iso-2022-jp?B?QXE5MDdCLzh0OTFQV3kzQ3RlZmUxa01LdG5RSHIxd2JkbnJTZDdwalJj?=
 =?iso-2022-jp?B?QlhoY0pkdkwxN1Rsdjc0R0dINS9nR3dFa0ZBdWczMXE4SkJJbzJTbGxh?=
 =?iso-2022-jp?B?UW9GUnlkeHhGYzZCWklZM0NJV1MxMWZvMnU2NVR3ZkxsRkdRZGRCdCtM?=
 =?iso-2022-jp?B?WDNZcTJLc2gzYXBZSTRxZXNoUVM3dmprcjV3UTdVckdBazNWZzl2aWRB?=
 =?iso-2022-jp?B?c2paVUtFQ2Z5UUQ0QWxUNS8wTW1Jc3BDUTVTYWdjeEdhWUJiRHc1L3cr?=
 =?iso-2022-jp?B?TGtvWWhUeHhmSkU4M0JEcUxiNVVkV2o5c2hLQ3d1ZHBiSlpOaGQ1YXBk?=
 =?iso-2022-jp?B?eGZqcS9mS2kyekNmc0MzbWlFVERjYWUwbldybE5rb3lsWXM4Q1hYQjBR?=
 =?iso-2022-jp?B?bWtsUlpCTHF4Z0MvVlpwb2dPS2ZaYnJ0aDF0UjNIRmRPVEl4V042d0ZJ?=
 =?iso-2022-jp?B?V0hhbnpXNjE5MkhldmRtNTZKTG9wbVpjbDNad0hBSldTUzh6NkZ3aEdF?=
 =?iso-2022-jp?B?Y1J1bzQwbEhWYzdHUmc0c1YxaTdZUzdQR0RBZnplQ0lqRWZyM2FUZWgr?=
 =?iso-2022-jp?B?TWwxQ2EwWFppb2xNZUhCRzcvNnlTM1VyQm9MOEdFbW9yODhsQ3JsUlhp?=
 =?iso-2022-jp?B?OHFPMmYwVS90c096M1BpdU1ZQ2NOU0xPemhySjdhWnBhR0Q3RkhmRmtI?=
 =?iso-2022-jp?B?SlErbUt1bHVNVVg2MHpHcWlrak1BQ0VrWThoZm5XUnE0a1FTMFJBeWEv?=
 =?iso-2022-jp?B?by94NkEvOG15Tk1JRys3ZFlwU2M1d3RMcUZ2SjFaMk5mL2tPZkJjRzRt?=
 =?iso-2022-jp?B?WGx3VFNNbFdmbVZtRjBzSmpDN2FraGNyWHZKekhpaDJJWVZnMU40OE5T?=
 =?iso-2022-jp?B?cTltd3YweXZFS1AzOGZDV0cvR2txbE1ONzBkQ1llWFJoKzVSb2lCZ3Rm?=
 =?iso-2022-jp?B?UW1jWGdQU081NzhMUGg4UjZhZ0VxMW9TK0NxY2JVMXB5Ym4ycDdLMXQw?=
 =?iso-2022-jp?B?NXR6RG9QM2VmRnYvV21FL1dHUEk4UURwdGF0MTBXN0pSeEU0V0d5WlEy?=
 =?iso-2022-jp?B?YWw4ZjlvVFpjVUVVSGhmekw4UWUyUnFxa0I3N3Bza24zQlBIamRuMXdm?=
 =?iso-2022-jp?B?UXBJQ0YwQzBlSmZrKzVqMk5VOEFnbUgrMjV3R1F4c2QxQ2tFYjZpU0d3?=
 =?iso-2022-jp?B?WCtXL1RQUlBib0xSWUZ4VHQycGs0Q1NUMGw3QlFvZUtzenFydCt1UjV0?=
 =?iso-2022-jp?B?WlZmeGNBSlNueXF3T2hhTlArK29tazVwVUFIeVcvSGVsckhYTGpuaExS?=
 =?iso-2022-jp?B?b0pBWWcrRE5zRkc3OEhVTXpqTGpmLzl3bFN6WWxOT21NUzZQUnBteTJa?=
 =?iso-2022-jp?B?Ukt3aWZsUGFhVlVXUFg4cVFSVWdaWFRPY3lZVllHY0xsZWpOT2pmTEZx?=
 =?iso-2022-jp?B?WTZYZXRld2FPSVFWa1VWM3BPaXYydkUycUpjLzNzanQ5enFxb2FmcHd3?=
 =?iso-2022-jp?B?TTc3TjJ6cnU4Q0dneHhGaU00UHNHbVlNTmpMODk2aytDNWo0OW9udnhW?=
 =?iso-2022-jp?B?NzljMWxSZz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ZAFXXE3krBphTOcPRIWaELaiOeUIVzw3ImEgPTeuaDldYLmDdfcinJvsRgWRGTFexmSe2GWPkKVQXAeN8NPCaDaFGa+cOHPgkHgoeRFp7cZymT3oGW3ubCStsbNiDbsP1xpGKPe8KpV4PAJM4WUn+QPOlHnxL+RY+Fx5RIp9otnoiEMDJ0XFw6aw6zICikKGQHW1/ac7TMBgnfrpK2cogBN6Rs4G+qNYnomE2YUVGsxnM8dUt7IFSPkQN6bCzdwptj6Qa4eCEJxA6GaT6ElHQduQzKlFUWT8gyeWnTusErPFwkIilXzdeMMpzuzaw6eLy3I78WJfhYYt/Hph+eeCrA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601d5a90-3660-48d7-dcdf-08def45d511f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 08:24:36.2959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZO4bR5sChkPRIFg3FkB9nVjOz/MMIlUviS/k4LUTtHiq0GLGEYCgbgslESP1AYsOaLYjLjVwcvTKfs5+ZiKeH8An2yZkFAlTun/t2p1aWlhmPg3OxPgvzXy49Sg/ElQT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10862
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Aug 2026 08:24:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23872

Hi all,

CIP kernel team has released Linux kernel v6.12.101-cip29.
The linux-6.12.y-cip tree has been updated base version from v6.12.96 to v6=
.12.101.
This release incorporates updates for the watchdog, USB, xSPI, clock, and v=
arious
dts for Renesas RZ G2 SoCs.

Information about this release is as follows:

  v6.12.101-cip29:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      6c6fd34960fb2eb93e503bfc06081c3ceb47bc07
    fixed CVEs:
      CVE-2025-39729: crypto: ccp - Fix dereferencing uninitialized error p=
ointer
      CVE-2025-39936: crypto: ccp - Always pass in an error pointer to __se=
v_platform_shutdown_locked()
      CVE-2026-45944: iommu/vt-d: Clear Present bit before tearing down con=
text entry
      CVE-2026-53005: af_unix: Drop all SCM attributes for SOCKMAP.
      CVE-2026-53260: tcp: Add preempt_{disable,enable}_nested() in reqsk_q=
ueue_hash_req().
      CVE-2026-53365: vsock/virtio: fix zerocopy completion for multi-skb s=
ends
      CVE-2026-63970: vsock/virtio: bind uarg before filling zerocopy skb
      CVE-2026-64192: bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BP=
F LSM is uninitialized
      CVE-2026-64206: Bluetooth: L2CAP: cancel pending_rx_work before takin=
g conn->lock
      CVE-2026-64227: ACPI: driver: Check ACPI_COMPANION() against NULL dur=
ing probe
      CVE-2026-64286: KVM: arm64: Clear __hyp_running_vcpu when flushing th=
e pKVM hyp vCPU
      CVE-2026-64287: KVM: arm64: Bound used_lrs when flushing the pKVM hyp=
 vCPU
      CVE-2026-64307: crypto: ccp - Do not initialize SNP for ioctl(SNP_CON=
FIG)
      CVE-2026-64341: USB: iowarrior: fix use-after-free on disconnect race
      CVE-2026-64352: bpf: Allow LPM map access from sleepable BPF programs
      CVE-2026-64361: hfs/hfsplus: fix u32 overflow in check_and_correct_re=
quested_length
      CVE-2026-64363: HID: appleir: fix UAF on pending key_up_timer in remo=
ve()
      CVE-2026-64364: HID: multitouch: fix out-of-bounds bit access on mt_i=
o_flags
      CVE-2026-64369: s390: Revert support for DCACHE_WORD_ACCESS
      CVE-2026-64371: proc: protect ptrace_may_access() with exec_update_lo=
ck (part 1)
      CVE-2026-64375: proc: protect ptrace_may_access() with exec_update_lo=
ck (FD links)
      CVE-2026-64390: ksmbd: track the connection owning a byte-range lock
      CVE-2026-64401: smb: client: resolve SWN tcon from live registrations
      CVE-2026-64405: Bluetooth: hci_conn: Fix null ptr deref in hci_abort_=
conn()
      CVE-2026-64413: netfilter: ebtables: zero chainstack array
      CVE-2026-64416: mm: swap_cgroup: fix NULL deref in lookup_swap_cgroup=
_id on swapless host
      CVE-2026-64421: media: nxp: imx8-isi: Fix use-after-free on remove
      CVE-2026-64428: gpio: sch: use raw_spinlock_t in the irq startup path
      CVE-2026-64434: Bluetooth: L2CAP: Fix UAF in channel timeout by holdi=
ng conn ref
      CVE-2026-64438: crypto: qat - fix VF2PF work teardown race in adf_dis=
able_sriov()
      CVE-2026-64441: staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie()=
, rtw_get_wapi_ie(), and rtw_get_wps_attr()
      CVE-2026-64461: PCI: mediatek: Fix IRQ domain leak when port fails to=
 enable
      CVE-2026-64462: PCI: altera: Fix resource leaks on probe failure
      CVE-2026-64472: vfio/mlx5: Fix racy bitfields and tighten struct layo=
ut
      CVE-2026-64481: ALSA: hda/cs35l41: Fix firmware load work teardown
      CVE-2026-64488: ALSA: aoa: check snd_ctl_new1() return value
      CVE-2026-64493: iio: pressure: mpl115: fix runtime PM leak on read er=
ror
      CVE-2026-64507: x86/bugs: Enable IBPB flush on BPF JIT allocation
      CVE-2026-64508: bpf: Support for hardening against JIT spraying
      CVE-2026-64509: rust: block: fix GenDisk cleanup paths
      CVE-2026-64510: ACPI: NFIT: core: Fix acpi_nfit_init() error cleanup
      CVE-2026-64530: net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qev=
ent_handle
      CVE-2026-64531: net: openvswitch: reject oversized nested action attr=
s
      CVE-2026-64532: fs/ntfs3: bound NTFS_DE view.data_off in UpdateRecord=
Data{Root,Allocation}
      CVE-2026-64533: fs/ntfs3: validate lcns_follow in log_replay conversi=
on
      CVE-2026-64534: nvmet-tcp: check INIT_FAILED before nvmet_req_uninit =
in digest error path
      CVE-2026-64535: nvmet-tcp: Fix potential UAF when ddgst mismatch
      CVE-2026-64537: bridge: cfm: reject invalid CCM interval at configura=
tion time
      CVE-2026-64538: ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().
      CVE-2026-64539: Bluetooth: eir: Fix stack OOB write when prepending t=
he Flags AD
      CVE-2026-64540: usbnet: gl620a: fix out-of-bounds read in genelink_rx=
_fixup()
      CVE-2026-64541: net/smc: fix UAF in smc_cdc_rx_handler() by pinning t=
he socket
      CVE-2026-64542: ipv6: ndisc: fix NULL deref in accept_untracked_na()
      CVE-2026-64543: tipc: fix use-after-free of the discoverer in tipc_di=
sc_rcv()
      CVE-2026-64544: crypto: asymmetric_keys - fix OOB read in pefile_dige=
st_pe_contents
      CVE-2026-64545: net, bpf: check master for NULL in xdp_master_redirec=
t()
      CVE-2026-64546: drm/edid: fix OOB read in drm_parse_tiled_block()
      CVE-2026-64547: net: usb: net1080: validate packet_len before pad-byt=
e access in rx_fixup
      CVE-2026-64548: bpf, sockmap: reject overflowing copy + len in bpf_ms=
g_push_data()
      CVE-2026-64549: Bluetooth: bpa10x: avoid OOB read of revision string =
in bpa10x_setup()
      CVE-2026-64550: net: qualcomm: rmnet: validate MAP frame length befor=
e ingress parsing
      CVE-2026-64551: sctp: validate STALE_COOKIE cause length before readi=
ng staleness
      CVE-2026-64552: virtio-net: fix len check in receive_big()
      CVE-2026-64553: net: psample: fix info leak in PSAMPLE_ATTR_DATA
      CVE-2026-64554: netfilter: bridge: fix stale prevhdr pointer in br_ip=
6_fragment()
      CVE-2026-64555: KVM: arm64: nv: Fix SPSR_EL2 restore in kvm_hyp_handl=
e_mops()
      CVE-2026-64557: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ne=
w_connection_cb()
      CVE-2026-64558: s390/pkey: Check length in pkey_pckmo handler impleme=
ntation
      CVE-2026-64559: s390/pkey: Check length in PKEY_VERIFYPROTK ioctl
      CVE-2026-64582: RDMA/rxe: Fix a use-after-free problem in rxe_mmap
      CVE-2026-64585: can: esd_usb: kill anchored URBs before freeing netde=
vs
      CVE-2026-64594: usb: gadget: f_fs: initialize reset_work at allocatio=
n time
      CVE-2026-64560: posix-cpu-timers: Prevent UAF caused by non-leader ex=
ec() race
      CVE-2025-40098: ALSA: hda: cs35l41: Fix NULL pointer dereference in c=
s35l41_get_acpi_mute_state()
      CVE-2025-68299: afs: Fix delayed allocation of a cell's anonymous key
      CVE-2026-45897: netfilter: nft_counter: serialize reset with spinlock
      CVE-2026-45901: netfilter: nf_tables: revert commit_mutex usage in re=
set path
      CVE-2026-53078: bpf: Fix same-register dst/src OOB read and pointer l=
eak in sock_ops
      CVE-2026-53090: bpf: Fix ld_{abs,ind} failure path analysis in subpro=
gs
      CVE-2026-53364: Bluetooth: hci_conn: Fix memory leak in hci_le_big_te=
rminate()
      CVE-2026-64205: i2c: i801: fix hardware state machine corruption in e=
rror path
      CVE-2026-64280: fpga: dfl-afu: validate DMA mapping length in afu_dma=
_map_region()
      CVE-2026-64290: iommufd: Break the loop on failure in iommufd_fault_f=
ops_read()
      CVE-2026-64561: KVM: x86: Check for invalid/obsolete root *after* mak=
ing MMU pages available
      CVE-2026-64562: KVM: nVMX: Hide shadow VMCS right after VMCLEAR
      CVE-2026-64564: sctp: don't free the ASCONF's own transport in DEL-IP=
 processing
      CVE-2026-64565: Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_=
process_data()
      CVE-2026-64567: btrfs: reject free space cache with more entries than=
 pages
      CVE-2026-64568: wifi: mac80211: fix unsol_bcast_probe_resp double fre=
e on alloc failure
      CVE-2026-64569: mpls: fix NULL deref in mpls_valid_fib_dump_req() on =
CONFIG_INET=3Dn
      CVE-2026-64570: wifi: mac80211: fix fils_discovery double free on all=
oc failure
      CVE-2026-64571: wifi: p54: validate RX frame length in p54_rx_eeprom_=
readback()
      CVE-2026-64572: ipv4: fib: free fib_alias with kfree_rcu() on insert =
error path
      CVE-2026-64573: Bluetooth: qca: fix NVM tag length underflow in TLV p=
arser
      CVE-2026-64574: wifi: mac80211: tear down new links on vif update err=
or path
      CVE-2026-64576: nexthop: initialize extack in nh_res_bucket_migrate()
      CVE-2026-64577: gtp: check skb_pull_data() return in gtp1u_send_echo_=
resp()
      CVE-2026-64578: ksmbd: validate compound request size before reading =
StructureSize2
      CVE-2026-64579: xfrm: policy: preallocate inexact bins before xfrm_ha=
sh_rebuild reinsert
      CVE-2026-64580: xfrm6: clear dst.dev on error to avoid double netdev_=
put in xfrm6_fill_dst()
      CVE-2026-64583: usb: gadget: udc: bdc: free IRQ and drain func_wake_n=
otify before teardown
      CVE-2026-64584: usb: gadget: f_midi: cancel pending IN work before fr=
eeing the midi object
    added commits:
      CIP: Bump version suffix to -cip29 after merge from stable
      dt-bindings: watchdog: renesas,wdt: Document RZ/G3L support
      dt-bindings: watchdog: factor out RZ/V2H(P) watchdog
      dt-bindings: watchdog: factor out RZ/G2L watchdog
      dt-bindings: watchdog: factor out RZ/N1 watchdog
      dt-bindings: watchdog: factor out RZ/A watchdog
      ASoC: dt-bindings: renesas,rz-ssi: Document RZ/G3L SoC
      dt-bindings: i2c: renesas,riic: Document the R9A08G046 support
      arm64: dts: renesas: rzg3e-smarc-som: Sort GMAC pinmux entries
      phy: renesas: phy-rzg3e-usb3: Fix malformed MODULE_AUTHOR string
      arm64: dts: renesas: r9a08g046l48-smarc: Enable audio
      arm64: dts: renesas: rzg3l-smarc-som: Enable Versa clock generator
      arm64: dts: renesas: r9a08g046l48-smarc: Enable I2C{2,3} devices
      arm64: dts: renesas: r9a08g046: Add audio clock nodes
      arm64: dts: renesas: r9a08g046: Add SSI support
      arm64: dts: renesas: r9a08g046: Add DMAC node
      arm64: dts: renesas: r9a08g046: Add i2c{0..3} device nodes
      arm64: dts: renesas: rzg3l-smarc-som: Enable watchdog
      arm64: dts: renesas: r9a08g046: Add wdt device node
      arm64: dts: renesas: r9a08g046: Add scif{1..5} device nodes
      clk: renesas: rzg2l: Rename RZG3L-prefixed PLL macros to CPG-prefixed=
 ones
      clk: renesas: rzg3s/rzg3l: Simplify PLL configuration macro
      clk: renesas: rzg2l: Simplify SAM PLL configuration macro
      clk: renesas: r9a08g046: Add RSPI clocks and resets
      clk: renesas: r9a08g046: Add SSIF-2 clocks and resets
      clk: renesas: r9a08g046: Add RSCI clocks and resets
      clk: renesas: cpg-mssr: Add number of clock cells check
      arm64: dts: renesas: rzg3s-smarc: Enable USB support
      arm64: dts: renesas: r9a08g045: Add USB support
      phy: renesas: rcar-gen3-usb2: Add suspend/resume support
      phy: renesas: rcar-gen3-usb2: Move phy_data->init_bus check
      dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3=
S
      usb: renesas_usbhs: Assert/de-assert reset signals on suspend/resume
      dt-bindings: usb: renesas,usbhs: Document RZ/G3S SoC
      usb: host: ohci-platform: Call reset assert/deassert on suspend/resum=
e
      usb: host: ehci-platform: Call reset assert/deassert on suspend/resum=
e
      usb: host: Do not check priv->clks[clk]
      reset: rzg2l-usbphy-ctrl: Check pwrrdy is valid before using it
      reset: rzg2l-usbphy-ctrl: Add suspend/resume support
      reset: rzg2l-usbphy-ctrl: Propagate the return value of regmap_field_=
update_bits()
      reset: rzg2l-usbphy-ctrl: Fix a NULL vs IS_ERR() bug in probe
      reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S SoC
      dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G3S suppor=
t
      reset: rzg2l-usbphy-ctrl: Add support for USB PWRRDY
      arm64: dts: renesas: rzt2h-n2h-evk: Enable xSPI nodes
      arm64: dts: renesas: r9a09g087: Add xSPI nodes
      arm64: dts: renesas: r9a09g077: Add xSPI nodes
      memory: renesas-rpc-if: Add suspend/resume support
      memory: renesas-rpc-if: Fix duplicate device name on multi-instance p=
latforms
      dt-bindings: memory: renesas,rzg3e-xspi: Add RZ/T2H and RZ/N2H suppor=
t
      clk: renesas: r9a09g077: Add xSPI core and module clocks
      mtd: spi-nor: add support for Macronix Octal flash

Best regards,
  Nobuhiro


