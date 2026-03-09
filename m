Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CD7EA8525
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 09:06:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9789.1773047174645531510
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 02:06:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=UXh1c8dx;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1773047163;x=1774256763;bh=
	3yV7h06rIPrkU6TPY19tEh+MtOCiNjwAL5e3HXj3JBs=;b=UXh1c8dxDZkKMUInRBECJlJ4PyffhB
	nREmHTxYmdAhnyv7ni8WYTNnkXBC189JUtjuaKGlM+KL9NA9PLEbyBAsM6YBBL+5SnAnLBTdDy0EG
	vivuekSLFUjFbP7LJMbeC4t+4gOOwsD8tB/6SLUpJo0DALBLELXfi8HojkY2btFKYTiFYAPVyIQlM
	DNycFwWhm4NgYuyTeBHcK/Z312xNV1QkuxqTdKzb6sTazgG93ZyEkS1S5+MyT+nlva5Zn6+LdJiwI
	edBUuN1LTx/eno1qVQYOyC7eyTXGzsz6DNe8p1z9fnoQYVQmkq3P75/MbZRBiUY2tFgUmPGDj1Ep9
	MQew==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6299629t2143370; Mon, 9 Mar 2026 18:06:02 +0900
X-Iguazu-Qid: 2yAaVgQnbDNtI4uiO7
X-Iguazu-QSIG: v=2; s=0; t=1773047162; q=2yAaVgQnbDNtI4uiO7; m=67/3HHiOWT2ed8dELZItqEJNmPmRa0w0DBfusBKi5RM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fTrhn5S5jzyPd; Mon,  9 Mar 2026 18:06:01 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBaOgBMcjm2EprZYKtQ4DslvaOpy09+vdAZm2YZI/+no3fsOi1458OlPlgDpqv7EQPVAuvvjxpO4hsQgfrkVrtx+f1wjkt04On9L0zC2yQEMy4wF5/Ni2tK6jJX3nVHV1YWr3afadE+qEVS1rxQ5cvADhUI7usIVt5jbHDQOysxR2R8cXvIZbilDGA6+pQf3009Kp2VJZE29nFl5Bzyk2Ht/Zk+sRybjDSHt6zVT7NH7cO0n7h76h3xhIKc3t33ROZ5s4JmN4OypiDorOiW6MArmvSIjW393ueqOOFRtJJk518aS91zJU0JQCftVMrX1xoCLkyYxJEDyN3Kou3Hd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv3PL6N5U5l3vot0XJqr/B63yMfJZJg/xuegQrYIAjY=;
 b=fjwSLd47fNJ6gKAsHvVtueGB1QgwHiy6L+uq0+o6j/B+WIaybk5ehlhdiEA3ob9s5PYdHSjdCetxQW8SN/SlAgtOvVcxHVHzfwouBUWAh5YpOYWOcjdLu/FMZJCqMhAqDq2PRdPli0mw2V4MGvosOc6QWAN1nyK9Rch7f/6OwLvVTdEkiXNTI/sJBvj1tkJyy5Cc8Vnyth+i6HJlfz2KIKp3JFVRxHg02cYaYel0avufNaerT7EQ407Tv1aiAB0p+ScA4x5MUw6Ejxq2GnUFm820ZVl2FbqwcnEsxWBhXA4uc1NxWlZroKYxlCuJ7bG1UtrdpvdnQmvLgeWl5DWXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.12.76-cip18
Thread-Topic: [ANNOUNCE] Release v6.12.76-cip18
Thread-Index: Adyvo7ioq5fm8MhtSt+h7L/y0Hwvkg==
Date: Mon, 9 Mar 2026 09:05:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148180663612C1BAD4584B06ECD79A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB12496:EE_
x-ms-office365-filtering-correlation-id: 8cdfbc72-36ad-45c7-9831-08de7dbb14af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|7142099003|38070700021;
x-microsoft-antispam-message-info: 
 WgW+umvDmCEafNLNJmidNPmGyYXcyk8PQ6JAep/6tYpI5wSCXwk5dCCYEe8v6MwRDN5ZeWCgT3gTUWXXLEI7HtwYjmDgQhWTcHazd2VHExh9SUWzY/2SRHH6v13/L2+8N9hloSMzmOaEzpnZ1AOaSqSdsOwg2vsw4IZ41cO8ipyhI0sUmx+H5JCKqWV1YmqBjzkokPNRIQ/GF/15JcpEfNp2320rfOGkaJrOMo9SLis5+sziCq+2Kg7+SwFyqG6OP49dbIdErtaWGAdUpsCq5EQAWO+opuJG0Q2AEKpMYly9AzvBCFGH/OBh9UE2bPxvAscEbtRIO0P0J50A14w4nLCShYud9vT2irCPHOw1d3Yf5PklHuQfuPD0aEhVnvSoGIFfFazzYDH4a6QP9l1mfM4Lj98ECT6SqPKjuB+/3eqEB94vWYBzrFziduplV75N+9MCrdPvW4e8/pK4PP1hgQnwx4/YcIM6CCzw1VW4UG4Llfkbjj/LPaTUg7zWvU1l8qG7rFICv1eD7NsT/SuZxQV9aQwwSt8/9IXYBBu1lygWI3Ys8dl6p2hgvsHVzKy4PAhV9gCzu1F+8Y9o6qPSZxPyl50+jzOWK/NPb/D7wRtmdKLFBBXJwtAILPFS9DAM88LNpf+SpgPHqkps11zxjnwzQipa0uu9m28J5r79tizd8H2DPymEhaz4gQSfL60oFXYoA9XKqqJ3z26CjHMPdz3vcCLeRl2EPwqKSP5S5HFYfGeUpHIiWCCeMX0QvMHHfUdHIQk1crzcyWmOVrtVZdRxO2cHQjd5pV+1dLIM668=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WWlFWHN4c1gxRmlMaVRyVENnblp2eGdpY0NjL3VhaHd6UTBXSm1wRnZ2?=
 =?iso-2022-jp?B?S3NCWVpIZlg1cGI0MFlDV3B5VXpVZjk0b2g4TUZCc3pSZE5zbGlmamcr?=
 =?iso-2022-jp?B?bXc3dHdFenptNGJNL0dQVzZkOGpuR2czaUdweC9aYjFSa0dHaE9vQkhj?=
 =?iso-2022-jp?B?SU1qekdvV3lvUGFBQ3g5eDArcXJMeXZwZDRSTUdiU1VsVW5lSmwwVVIx?=
 =?iso-2022-jp?B?bElzS3p0aGI0SXpaa1FzSFBDTEdiUmc4c1ZGVFdwbHhFWkJsOUl1dzl2?=
 =?iso-2022-jp?B?NWdIeSt2U1I4aXNoR3lMcm5yWFhZYzZWMkpWc3ZjazBOZmc4bm52WUZq?=
 =?iso-2022-jp?B?U1lRVTlzbVBjbXp6NXBxUEtqaUhPT1BzdytvS3dTaW1XcVBaeDljMkFV?=
 =?iso-2022-jp?B?NVVLMXp1aWhoTTVWNWtNWVR3RmM2L0JBV3Q2WGlGRE4rbTFmdzRpT3Rr?=
 =?iso-2022-jp?B?ZW8vVUJoQ2NhRzlDanFSWk1NQnNOZHM2RWc1QXZJUFQzYlVVYmYzMmpB?=
 =?iso-2022-jp?B?cnQ1bUdTVEZqVlZod0pVUkRHMnQ4VU10NnVMSW53NXBIZmZmaEhMb2Nr?=
 =?iso-2022-jp?B?UEMyNG01Q2ZrSjZVb2NkWjVpSW14SHN4S09yazRVRGJnU3pUSVJKVTVm?=
 =?iso-2022-jp?B?Nkg0cGVKK2tNZ29uYnFHZXFLY1lqNjFjVFZtcHNybUNKcFJ0UUxhdGxI?=
 =?iso-2022-jp?B?dUFDc3FvZFl3S3REcFdEc014Z21nREIrdktHQ0FnVFllMGxDQUhuZDJJ?=
 =?iso-2022-jp?B?MzlCNUxKRjVKRHVlbW13MFFtM1NiaGdIRlNPclNsNm1XMWxqSjBKNXVn?=
 =?iso-2022-jp?B?UVFnOFNlRkVPb2NMZmFWSHN6VlVxRFY2SFVtWkxKS2hxaXNod1BrL2NU?=
 =?iso-2022-jp?B?TXpyYm9vMEtkY0ErNlFiZTBQZlBtMDl2R3owQ2lMcG5FM2xZZDFHN2s4?=
 =?iso-2022-jp?B?WFNUVUFJWm1ENTFhdFZzcWJkaWlJb3JUNDR6Qm1SeVhUMTF4cFdjcWZL?=
 =?iso-2022-jp?B?NTdxUEZJOUowcHhnWG1EQTljdnJLRXlkckMrVjIwSjU3emExTmk0Zysz?=
 =?iso-2022-jp?B?d3Y0MzhPQUl2Mm9uVy9EWWlrK2IwR0VFVit1U0VMR3FQcmRXNm96YWRJ?=
 =?iso-2022-jp?B?S0x6cTN3cVRuUXkzOUhKK2hEOVRpSkxTVGpUcGpmVXdoNmFwTWoyOGNB?=
 =?iso-2022-jp?B?ZTVqa1Z0VUE0V2ppNjFHVVlZS0t1L1l4enVRNTdyNEROeGN2Y0pVV3RY?=
 =?iso-2022-jp?B?WmZDNkpkWkcwRldDcEtob01ySnNoV05tQkZ4VUJxZTJCYVlFUTVISm1h?=
 =?iso-2022-jp?B?RUg3Rkg2Nk5zMWxBVEdtbjdLUmVsMk85SWpWbm92dUxuMm1rZ2FuUHlC?=
 =?iso-2022-jp?B?U2JHMHkweTZ0NVNyRE42OUVKamhxakhQM2JhZldmc0c4SXhtVi81VmRp?=
 =?iso-2022-jp?B?SHFJOEVPUEgyM3Avd1RMUTBMQmVMYnkrKzdCR0VmYk1pU3NvdU16S1ZI?=
 =?iso-2022-jp?B?ZEI2c3pPeGorVm1iYU9xQW9RVEpGeDEvZUcxRC9JVlNrMHZKeWkrNzRD?=
 =?iso-2022-jp?B?THRCZEVIZkpRODFZYTcyL0lNbG42ZE5YanJOaUVvS2ZIdlJTaVlITkdH?=
 =?iso-2022-jp?B?aDNRY1U4OWVydG5jWUxCajlnUDMzRHYwd09pVkhSQk11QVdWZ2Q5NXN4?=
 =?iso-2022-jp?B?L1R5ZzR1K0lqTmtEY25yWVRTWURFS0xrOWpwUGJ5UlFUVm9JWXZZV0t5?=
 =?iso-2022-jp?B?RHIzRlRtTEpRWUd4VGtkeWVnbVZueGJqS0lsQnBubWtvTjBqWEhOMVQz?=
 =?iso-2022-jp?B?Zld2QzMrd0N3YS9JUFpNYk81c0NJaTFiTFBiL0l1MmRQYTBkemVVQ0J1?=
 =?iso-2022-jp?B?N0o2TnRKU1ZnM2hCeGp5RGhiaWM4MHplTUFub1YxSERIM1J0Yi9hV0Fa?=
 =?iso-2022-jp?B?V3RtYUd2M1c3dm5NRXFmd0JXVmxNZktYRTBvS0g2MUMrdVhXaXkxU1NN?=
 =?iso-2022-jp?B?RGFKQ0RBc2VmaU1FL0JaUlJYNGp5alN3SW53aUZ6MnRIMFFHOXowVE1L?=
 =?iso-2022-jp?B?RCtOSGdzazFuS1NoY1BESkxNN296NWI3Qkw3NFNnSzV3SXFncVcyUGxo?=
 =?iso-2022-jp?B?YkF3WVFXcm01NnVuZjNwak9BOEtYRTkvNFk0TDBBcUNiZzZpbnJTaklP?=
 =?iso-2022-jp?B?eUkydjdSeHZyQ0R2WHBaeUpuNXFhU3BwaDZLa1V1TXB0QWVwZ3h1V1FV?=
 =?iso-2022-jp?B?MDNaNis5L2phNTgxSm1XVWZCaDgzUmlyTndERE5vOHdia0I3YVN5elo4?=
 =?iso-2022-jp?B?eEhaYWd2eXY2SDlDczdJZDUxL3ZvWDd5bGQ1TUp5NCtsSm9hb256eVZI?=
 =?iso-2022-jp?B?aFVsVllkTnp0a3ZWN3RyS1NJbGRIZGovd1U5VHY3a2xqL2JHaHNHdmgr?=
 =?iso-2022-jp?B?UFdZUDNBdnd1TTQ1VWk3QU1veFlMVzl4SEg5NVJNNG5RR2JNZmNIZXJX?=
 =?iso-2022-jp?B?ZnRGOWhPNFYzRXNpR2YxR2ZCSFJiZ21WTERhNkloK0gySURNM2FVS01x?=
 =?iso-2022-jp?B?VGVkZ1JYMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	bYpJ040EFjQ5tqLKAeBF4yjVTzOvqKQOKtqSAuNINLNmaBcgWdnZByzsPJngYBX88/2B3rIwpfBIJvh3FyWA51bggECnW4zOA/alS8FANLgfRFxF3eJBPLTfp4HKIZFUgKlkZON2/c0Az9V5Y/0sJE9ETtRrRKflSQniJKGNMTiyJ+38TVZyIcbPqZ/liM2K+yWMcyND+ulSInNpeB35KGYZcB3fby21Y8zye8bMkBiEfoSHixGUqm2H75lnGjErm05IY0HOKGRScK6OOjLyyqBhoMTVilhDRoQKmI1cKRvI4yUPr2EFM9saZ6NbO3j8oqbTApg0sbudixU4QFUzzw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdfbc72-36ad-45c7-9831-08de7dbb14af
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 09:05:59.2154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kfl0Be0ezIVsk4ZfA2f00BvcfJCFxKxpA1q6/Mkjka2dt9Sx7WNRWTFrTvqzKsiIMLDDNNlDyL+iqA3AU4mhFUWYmAlSTCQZoUXg6YEueLcrfGRP35gbwDYR/YNz87T9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12496
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 09:06:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22166

Hi all,

CIP kernel team has released Linux kernel v6.12.76-cip18.
The linux-6.12.y-cip tree has been updated base version from v6.12.69 to v6=
.12.76.
This release includes updates for the Renesas ARM64 SoC RZ V2H.

Information about this release is as follows:

  v6.12.76-cip18:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      9a01a3b1643c723d1dacacef2f495d84f2a676fa
    fixed CVEs:
      CVE-2025-40082: hfsplus: fix slab-out-of-bounds read in hfsplus_uni2a=
sc()
      CVE-2025-68823: ublk: fix deadlock when reading partition table
      CVE-2025-71203: riscv: Sanitize syscall table indexing under speculat=
ion
      CVE-2025-71204: smb/server: fix refcount leak in
parse_durable_handle_context()
      CVE-2025-71220: smb/server: call ksmbd_session_rpc_close() on error p=
ath in create_smb2_pipe()
      CVE-2025-71222: wifi: wlcore: ensure skb headroom before skb_push
      CVE-2025-71223: smb/server: fix refcount leak in smb2_open()
      CVE-2025-71224: wifi: mac80211: ocb: skip rx_no_sta when interface is=
 not joined
      CVE-2025-71225: md: suspend array while updating raid_disks via sysfs
      CVE-2025-71228: [REJECTED]: LoongArch: Set correct protection_map[] f=
or VM_NONE/VM_SHARED
      CVE-2026-23111: netfilter: nf_tables: fix inverted genmask check in n=
ft_map_catchall_activate()
      CVE-2026-23112: nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_i=
ovec
      CVE-2026-23176: platform/x86: toshiba_haps: Fix memory leaks in add/r=
emove routines
      CVE-2026-23177: mm, shmem: prevent infinite loop on truncate race
      CVE-2026-23178: HID: i2c-hid: fix potential buffer overflow in
i2c_hid_get_report()
      CVE-2026-23179: nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready(=
)
      CVE-2026-23180: dpaa2-switch: add bounds check for if_id in IRQ handl=
er
      CVE-2026-23182: spi: tegra: Fix a memory leak in tegra_slink_probe()
      CVE-2026-23187: pmdomain: imx8m-blk-ctrl: fix out-of-range access of =
bc->domains
      CVE-2026-23188: net: usb: r8152: fix resume reset deadlock
      CVE-2026-23189: ceph: fix NULL pointer dereference in
ceph_mds_auth_match()
      CVE-2026-23190: ASoC: amd: fix memory leak in acp3x pdm dma ops
      CVE-2026-23191: ALSA: aloop: Fix racy access at PCM trigger
      CVE-2026-23193: scsi: target: iscsi: Fix use-after-free in
iscsit_dec_session_usage_count()
      CVE-2026-23198: KVM: Don't clobber irqfd routing type when deassignin=
g irqfd
      CVE-2026-23199: procfs: avoid fetching build ID while holding VMA loc=
k
      CVE-2026-23200: ipv6: Fix ECMP sibling count mismatch when clearing R=
TF_ADDRCONF
      CVE-2026-23201: ceph: fix oops due to invalid pointer for
kfree() in parse_longname()
      CVE-2026-23202: spi: tegra210-quad: Protect curr_xfer in tegra_qspi_c=
ombined_seq_xfer
      CVE-2026-23204: net/sched: cls_u32: use skb_header_pointer_careful()
      CVE-2026-23205: smb/client: fix memory leak in smb2_open_file()
      CVE-2026-23206: dpaa2-switch: prevent ZERO_SIZE_PTR dereference when =
num_ifs is zero
      CVE-2026-23209: macvlan: fix error recovery in macvlan_common_newlink=
()
      CVE-2026-23213: drm/amd/pm: Disable MMIO access during SMU Mode 1 res=
et
      CVE-2026-23214: btrfs: reject new transactions if the fs is fully rea=
d-only
      CVE-2026-23215: x86/vmware: Fix hypercall clobbers
      CVE-2026-23216: scsi: target: iscsi: Fix use-after-free in
iscsit_dec_conn_usage_count()
      CVE-2026-23219: mm/slab: Add alloc_tagging_slab_free_hook for memcg_a=
lloc_abort_single
      CVE-2025-71229: wifi: rtw88: Fix alignment fault in
rtw_core_enable_beacon()
      CVE-2025-71231: crypto: iaa - Fix out-of-bounds index in find_empty_i=
aa_compression_mode
      CVE-2025-71232: scsi: qla2xxx: Free sp in error path to fix system cr=
ash
      CVE-2025-71233: PCI: endpoint: Avoid creating sub-groups asynchronous=
ly
      CVE-2025-71234: wifi: rtl8xxxu: fix slab-out-of-bounds in rtl8xxxu_st=
a_add
      CVE-2025-71235: scsi: qla2xxx: Delay module unload while fabric scan =
in progress
      CVE-2025-71236: scsi: qla2xxx: Validate sp before freeing associated =
memory
      CVE-2025-71237: nilfs2: Fix potential block overflow that cause syste=
m hang
      CVE-2026-23169: mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
      CVE-2026-23220: ksmbd: fix infinite loop caused by next_smb2_rcv_hdr_=
off reset in error paths
      CVE-2026-23222: crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY scatte=
rlists correctly
      CVE-2026-23223: xfs: fix UAF in xchk_btree_check_block_owner
      CVE-2026-23224: erofs: fix UAF issue for file-backed mounts w/ direct=
io option
      CVE-2026-23228: smb: server: fix leak of active_num_conn in
ksmbd_tcp_new_connection()
      CVE-2026-23229: crypto: virtio - Add spinlock protection with virtque=
ue notification
      CVE-2026-23230: smb: client: split cached_fid bitfields to avoid shar=
ed-byte RMW races
      CVE-2025-71238: scsi: qla2xxx: Fix bsg_done() causing double free
      CVE-2026-23100: mm/hugetlb: fix hugetlb_pmd_shared()
      CVE-2026-23221: bus: fsl-mc: fix use-after-free in driver_override_sh=
ow()
      CVE-2026-23233: f2fs: fix to avoid mapping wrong physical block for s=
wapfile
      CVE-2026-23234: f2fs: fix to avoid UAF in f2fs_write_end_io()
      CVE-2026-23235: f2fs: fix out-of-bounds access in sysfs attribute rea=
d/write
      CVE-2026-23236: fbdev: smscufx: properly copy ioctl memory to kernels=
pace
      CVE-2026-23237: platform/x86: classmate-laptop: Add missing NULL poin=
ter checks
      CVE-2026-23238: romfs: check sb_set_blocksize() return value
      CVE-2026-23231: netfilter: nf_tables: fix use-after-free in
nf_tables_addchain()
    added commits:
      CIP: Bump version suffix to -cip18 after merge from stable
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable DU and DSI
      arm64: dts: renesas: r9a09g057: Add DU and DSI nodes
      arm64: dts: renesas: r9a09g057: Add FCPV and VSPD nodes
      drm: renesas: rz-du: Drop ARCH_RZG2L dependency
      drm: renesas: rz-du: Add support for RZ/V2H(P) SoC
      drm: renesas: rz-du: mipi_dsi: Add support for RZ/V2H(P) SoC
      drm: renesas: rz-du: mipi_dsi: Add LPCLK clock support
      drm: renesas: rz-du: mipi_dsi: Add function pointers for configuring =
VCLK and mode validation
      drm: renesas: rz-du: mipi_dsi: Add dphy_late_init() callback for RZ/V=
2H(P)
      drm: renesas: rz-du: mipi_dsi: Add feature flag for 16BPP support
      drm: renesas: rz-du: mipi_dsi: Use mHz for D-PHY frequency calculatio=
ns
      drm: renesas: rz-du: mipi_dsi: Make "rst" reset control optional for =
RZ/V2H(P)
      drm: renesas: rz-du: mipi_dsi: Add OF data support
      drm: renesas: rz-du: mipi_dsi: Use VCLK for HSFREQ calculation
      drm: renesas: rz-du: mipi_dsi: Simplify HSFREQ calculation
      clk: renesas: r9a09g057: Add clock and reset entries for DSI and LCDC
      clk: renesas: rzv2h: Add support for DSI clocks
      clk: renesas: rzv2h: Use GENMASK for PLL fields
      clk: renesas: rzv2h: Add instance field to struct pll
      dt-bindings: display: renesas,rzg2l-du: Add support for RZ/V2H(P) SoC
      media: dt-bindings: media: renesas,fcp: Document RZ/V2H(P) SoC
      media: dt-bindings: media: renesas,vsp1: Document RZ/V2H(P)
      dt-bindings: display: bridge: renesas,dsi: Document RZ/V2H(P) and RZ/=
V2N
      dt-bindings: display: bridge: renesas,dsi: allow properties from dsi-=
controller
      i3c: renesas: Add suspend/resume support
      i3c: renesas: Factor out hardware initialization to separate function
      i3c: renesas: Store clock rate and reset controls in struct renesas_i=
3c
      i3c: renesas: Switch to clk_bulk API and store clocks in private data
      i3c: renesas: Simplify return statement in 'renesas_i3c_daa'
      clk: Provide devm_clk_bulk_get_all_enabled() helper
      arm64: dts: renesas: rzg3e-smarc-som: Enable I3C support
      ASoC: renesas: rz-ssi: Add support for 32 bits sample width
      ASoC: renesas: rz-ssi: Add support for 24 bits sample width
      ASoC: renesas: rz-ssi: Move DMA configuration
      ASoC: renesas: rz-ssi: Remove trailing comma in the terminator entry
      ASoC: renesas: rz-ssi: Use dev variable in probe()
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable Mali-G31 GPU
      arm64: dts: renesas: r9a09g056: Add Mali-G31 GPU node
      clk: renesas: r9a09g056: Add clocks and resets for Mali-G31 GPU
      dt-bindings: gpu: mali-bifrost: Add compatible for RZ/V2N SoC
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Rename fixed regulator n=
ode names
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable Mali-G31
      arm64: dts: renesas: r9a09g057: Add Mali-G31 GPU node

Best regards,
  Nobuhiro



