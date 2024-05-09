Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A829C10F1A
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 05:35:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.3449.1715232921094829245
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 May 2024 22:35:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4495Z0DJ875905; Thu, 9 May 2024 14:35:00 +0900
X-Iguazu-Qid: 2yAbAhOaceMYrbCld7
X-Iguazu-QSIG: v=2; s=0; t=1715232899; q=2yAbAhOaceMYrbCld7; m=EF5/MKWs5yQwhGPdnBz22GoEq+ZHp/keAGBkFlL+xmw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 4495Yv3v1136003
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 9 May 2024 14:34:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0W+u9EYmiLmzhe1GaLdGmhkck9OtM++zJ96q6BSkaMFARJdE/TlqhGsMP0LujkBn9aeIiYwV/lJ7lUt3qe/JqMj7JKxLiUikoNVCzo5fVjz6n9zlnuNs6w/BTB/uQzbBR9Gv6qnAm5inwW0O5u1wJuZJd45c6vCn7mb6UAn9ChEnJD8CWr5/zyEa7AT7d7nvk478jBYDop/A4uApRbxnVAmxxxUaTuV1NONnAObrhTbhVH7cQTVD7MIKTPFX66xBCjPfZiPJzwWwuFdL1CHE9T5EFS2SCgGGkLRTt+R8yNHBYu+rJ6dHGNdoS4x3MvwGSh/2S1CDp+b7HZyUPddDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXSZw4EwvOgr6z1NPtudLiZfc9ecvb+OK6TIdn+K0OE=;
 b=QxIbJJQi73d9rjLIIniLjMvkAbova/DjtcDG+pJjT5+QCn7nAWvi0e1TaOyNPLTtUdMDli4zbKlgY0H13MU2fy0OAClnjB1wr/9DoAeeO9wODgwlfNMdEUWBEphh+BfZRx20zpqyQF4ZG6HPBah1/3DXK2Te5U00JD89ektQnLEO1sTU4CBXvMSTuhMbtFN98NzcTR800aDihc919z7JCe6Tns/MJB1nlJ2d+ShYKdmndOAZV/b9Ex3bCms1pktrzn/nYSGVZ0uJuVFRxRN6B6WqFwowuFSnjKn+1omYVOakqfKbcxiCYFoFjyI1QN+dJnZeg4HVbf58kmahgvszCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>, <pavel@denx.de>
Subject: [ANNOUNCE] Release v5.10.216-cip47
Thread-Topic: [ANNOUNCE] Release v5.10.216-cip47
Thread-Index: Adqh0Wcgqrq5HJ8+QIWaSbhtB0b7eQ==
Date: Thu, 9 May 2024 05:34:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB63913DB72DD1D9B2ACEDABA492E62@OS3PR01MB6391.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|OS3PR01MB10201:EE_
x-ms-office365-filtering-correlation-id: a0698d11-3c17-4800-c988-08dc6fe9c209
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|366007|38070700009|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SkJWNXBBaVF2NnA4SFo1Rm1JU2g0TG1vNkgwKzhzaWp6cHI2WVloZDRj?=
 =?iso-2022-jp?B?Y2NBV1ZyaVFrd2hnMURhaUdQdlhjaTlzK1NacDB4VjE3a3kyVnBVZnVw?=
 =?iso-2022-jp?B?c1BnWDNjZjJ2S1dMeHZzTW90cm54TGpYNkViTFpWekoyZmFTWjVaMkUw?=
 =?iso-2022-jp?B?Z0VJS3N4VmEvZDljNDRUM1ZyRDN4MnM3bDhxZFJWSzZGVC8reUN3bGtN?=
 =?iso-2022-jp?B?QUtMSHpvMXE5SnVoc2xJcUVEbmdnWEw5RUs5TStwQmxTVWJRMHBHb2lQ?=
 =?iso-2022-jp?B?ZXhTRXRTR3ZWS1kzTFdMLzFOTWFtMnlUZUxXZjUxcUh5R3ZteEJFblBj?=
 =?iso-2022-jp?B?c3VjYjJ0QTJBSXNNWFl6bHAwZHUyVkw0ejVhODdpUW9lRVkxZk53MTRw?=
 =?iso-2022-jp?B?ZkxrQXB3TkxrOGZJd2ZzS05IVDBIV1dzbnhhcEpRWlNuK2hRaW92Wkoy?=
 =?iso-2022-jp?B?bVFXb0V6QUlQQ1VhMTNtZStaVWQxVTRjU011dFZNZ0dqSFR2Q25Pd0JW?=
 =?iso-2022-jp?B?U1ZJV3BPSWsrMWgyYzZCcHdwOGpzQXBjWHlFbU54ckdvblpXbkdFUjhO?=
 =?iso-2022-jp?B?NnQvUnkrWEU4dmhQUVVmT3R5ZjdSNVAwcXdEdkFDMzFlTGZLdmlNZ3BL?=
 =?iso-2022-jp?B?VDd6RmJNeWNBZTFLV25SK095VEVpTVVRaFJSeHU2eFBFRTIvbDZnTzZ3?=
 =?iso-2022-jp?B?alhYbTZDdlExLzJsOWlsV0U4UVZLZmxqWTQzQzJRZnhJbzBqanV3RFFr?=
 =?iso-2022-jp?B?Q2Nub0hJbWM3VjVZbmNLT1BsM1N3cmhsVEUrQk95dVUzbEg2VXM5Z0do?=
 =?iso-2022-jp?B?QUxSZjVxZE1kZFlXZVhBSG1BVHBlTFNKYndTTVF6YVdpMnpYbXVML3Rm?=
 =?iso-2022-jp?B?ZnQ3clI3MndqUDVZN0lLOUxuWW9aQTU3eXE0c0txYWNrWWRDR1NUaUtO?=
 =?iso-2022-jp?B?czZScHozMWl2YzZFM29lalBjRkE3dVpXdTlUSy9MQ1daZjhRRnFoUUcx?=
 =?iso-2022-jp?B?amRkRnJhb1ZxY0lMNlFTRFRwQm1TQU9aMXcrL290T1loNlNMdUxyS3Rm?=
 =?iso-2022-jp?B?eG1MRUtxeXg5SXBFN1BGa2M5UERSM1FnSVZCYU5xNzlvVXVtQ000VExD?=
 =?iso-2022-jp?B?bysxbmlIWkdmb0dGZlo2YUMycWhvMXRnbWUxWGFiYVpqRTJTb1FGTWY3?=
 =?iso-2022-jp?B?TjlKUXFrNTlFWHRYbk1DTWREV1o2VW9sYVRjVjExSGxURUVXcUxsU2NU?=
 =?iso-2022-jp?B?dmJ4aHBXdDByalJTYVhOSGNWMkY2Vi9QZ1pkMml3bDEzR3VoMlJiOWp3?=
 =?iso-2022-jp?B?T2txVmVHZVVMTFlQMlBxc2xHT2VNS1BxUUJ5L0pNM0RnZ0NQK0txWmdE?=
 =?iso-2022-jp?B?QjJlaGcrdkhGakRuZDBSUTY1RUpOMDRaUCtHUFpNN0E5ZUtmRXdXanBX?=
 =?iso-2022-jp?B?cmJxRGU4L1ZoeWpOQUdhK2p1S2E0dHVKYUhkbUhvVCtvOWIzSlk5OHl5?=
 =?iso-2022-jp?B?V0M3REluZHhtTE9TeDlMT2hPakRwZDNTRDQ4RWhkTWN1L2doeGEwRHgz?=
 =?iso-2022-jp?B?UHpIbVhpNVdHbCtjQ0dEM3A2c2NCd3JoOE53VW5hUUVRN21YeU0zUjJ0?=
 =?iso-2022-jp?B?THNZSzArTUFNL1lZSHBBc3dvek9zdzZZazQwbmRGK2NkanlkNXVaZFcy?=
 =?iso-2022-jp?B?OFJGb2RwMWEzVHh3RGxlYjZidWFjK01TbWxmbVp1WGtsL1dKTXRsVHBW?=
 =?iso-2022-jp?B?Slp2bGRpTlNBMjJqZlNPTTBVQXRDVDRaNlpPaWt1ZlB0YlJETGlNMzNm?=
 =?iso-2022-jp?B?R0V5bmdOOHU3RU5qdG90eU00VmI1VmVra0Fnc3FpeHRESmlqRVZwTkZL?=
 =?iso-2022-jp?B?aHIrak44ZVNibEJLajY2b3IydklTUHJNM1FyK05meVYwY1RYV2Z0M1kr?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6391.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UUdpdUV6S2psTC96RE1XdHIyOWRVVVRoVW1yYnJjelI3ZXdSazg2dFdx?=
 =?iso-2022-jp?B?SFZrSnVXWlhqTmdKNHh1RHZ6SjVWZDRmREN1SlIwRC9lN1gzVnk4U0Nv?=
 =?iso-2022-jp?B?UVVnV3VycGJoVHFYS1BoZjhBZWN1Z0Jrcm5Lc2VqUzRNdUx4elZWaXNu?=
 =?iso-2022-jp?B?b2F2SFhiN1JpdUdhb2VxODlocmlGRko2T3hxVURyY3F5cFFDZGh6U3FF?=
 =?iso-2022-jp?B?SGdiWFFzc2FoMktpTFVoWFBNbE4wQldZblF0bHVSbUNOOW9SRjVydUFj?=
 =?iso-2022-jp?B?RFdHajFDUTZKWkxYaHB1TE43aERNbkd6empwZmtxNXk3UEwxaFN4NXBH?=
 =?iso-2022-jp?B?cjJ2N1Y0ZWpaa0V3ZmJMT08vZWpRRXE4K09hSWNLMHVDaVRkdkNialNO?=
 =?iso-2022-jp?B?ZzQ0Mk1KbHRpNWg0cVNocUlrekVpcEdySGJTMVVXWHd0S1djMEUrN2ht?=
 =?iso-2022-jp?B?S3I1TURhUEJRVXcyMzRpOGI1MmdJWUp2VjBjU3Y5K1RlOSsxNVpGbGQw?=
 =?iso-2022-jp?B?TXhUR2VmU0ZWckk1K3R0SEdJSzQvRngvUnVFYndlOVhhSXdLMWRXblZL?=
 =?iso-2022-jp?B?bVl3bTRYU1pnc3RCTEQ0dE5GUUI3VXMvRmlpbUgyYTIrdkJrN3dOSWpQ?=
 =?iso-2022-jp?B?SnUrdnZMeWYyM1l3VTBWQ0k0S2FxVk9JN1pnVUsvSDBWTkhGcStvNERj?=
 =?iso-2022-jp?B?S0ROQWtnb2tGTllHemtveEJUOWlGM2JSNEFzK2hacURNVDJLdjRFMWFh?=
 =?iso-2022-jp?B?QVArNHlnVlIvcEFRNFZQMS80czhEeEpVNHlZc0YzZGNERjhLQkZNdHlr?=
 =?iso-2022-jp?B?cFVlTDF6RzZqakRFNEsrWmNhaXRPWjJSZEVlWENReGdMNFhYNWZ1ak9P?=
 =?iso-2022-jp?B?YUVjTDVnWWhucUNGSlVsa1hhUlJNeHhiUzdsTG9wV1FSSXBLOFJ4aEE3?=
 =?iso-2022-jp?B?MEtwc0FoQmxtMWQvZTRnanZuTTNjdkF1ZVdGNWdhZVRCQnY4M2hhb2U4?=
 =?iso-2022-jp?B?WXpEZER0bjVzZEtzTGROZHF3ZTdNMUI3cXlaa3pEaWtqd092UVFvUDVj?=
 =?iso-2022-jp?B?VjMxZkpuSkRRcGFobUlERmR4eWZoN3QzaXNZMzlDb3l1VUVLLzgwV2Fw?=
 =?iso-2022-jp?B?VTFqTkFrclc3RGdkdEZiYVY5cFVhcEtEM3d2V2lnaWxidGg2QWViYUt4?=
 =?iso-2022-jp?B?QmFCVU9Fc1RtWnVQckdHMHl2ZU1aRjQ1RWh1eS9QK2pjWSs2MWJNQmQ3?=
 =?iso-2022-jp?B?L0U0cThMMktQanhrY1didFA0VDQ2cUJDWXppWDBKVXRxdkhFMHQzbGtz?=
 =?iso-2022-jp?B?Tk1rb1FDV0NDd2VVY2tzbU9yODFzcWZ6Q3o0dmlmSHp6V1Z1MityeFF0?=
 =?iso-2022-jp?B?OUtCMTlGeUs5WVNsUCtDaDRvV3hsek01cUVHblJETUhYa1EvRDI3aFhL?=
 =?iso-2022-jp?B?bEwxOWplQ1Z1NGgya0N4R1lmTTNTaU5Kckh3dlpsTkRjbG4wK0pqZHkv?=
 =?iso-2022-jp?B?cnkwajFmSUFvb0xETmp2dTNNUHRjVXl0RjNBY1k5RnNNTG5NVVZ5eDR0?=
 =?iso-2022-jp?B?MVluaU1FOWd6YWJmd0M1cUVrVWdnUnc5Qm5yb3dTT2pMajIvN2NMcmU1?=
 =?iso-2022-jp?B?a1RHZk1xYlY4eFl1eG1hZHg0Zk1aQUNsQmJzQjc5N0N5OXFnNVZaU2hm?=
 =?iso-2022-jp?B?azFuODh5dHRPMThUdkhDM0NBQ2lQQU8vK0l4aHlvMCtnU2xGUUJJakxY?=
 =?iso-2022-jp?B?dlltRzBaTmtZWDY2Q0tiUExyWU4yZzhDbGJ4bVBPWkVPa1hIRE82RzZQ?=
 =?iso-2022-jp?B?dmtFUXkrQ1JnM3BpN3Z5RWtPM3JSWEhvdEd3b2FYK00yd0hEWWdkYlhV?=
 =?iso-2022-jp?B?MG1ndHhBeDd3WnhpTzJ1bFpFZEthWEdlcld1NlR4R1h0c0NqdHoybTlq?=
 =?iso-2022-jp?B?a0t4S2pFa3U1MVhycHNlWkIyUE1SVnl0bWxlZEFVNVNCd2hSK3VRTExt?=
 =?iso-2022-jp?B?ck4wTTFVV2x3K1c0WUhyVXowcE1xVkxsc2JFVjNtWFVPNHlxUkhXQ2JM?=
 =?iso-2022-jp?B?RHE4SDk5M2RvQTlGRldXODNFOWx1ak9iKzFxaEl6QmtXK3dUTmJYNmxO?=
 =?iso-2022-jp?B?WFFBK29IdUFER0FBYy90UmU5dDRrcmE2SUFWRzhwd2NkYmI3bjliVm5O?=
 =?iso-2022-jp?B?V2hYUkYzRVNiTmIvUEFJbi9nRXFQNEhhS3F2TG8rNHhWemM5TjBGNFhU?=
 =?iso-2022-jp?B?dDA4ZzNqMU1oZWwramErZjAwUWlyb1MybGRZVVV2WUt2d2cxcU1CZ0RR?=
 =?iso-2022-jp?B?Y2pjVHFNaGNOS1hTVTZsNjAyVzQ4Y1VJUWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0698d11-3c17-4800-c988-08dc6fe9c209
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 05:34:55.2798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k2U9lv8sFgJ2PvNIu1f5/jh1mnMfMGlKoNy2tTzjYJa8m8vcrRFwNxugadndUKIkNvYBneRITF/j6dBEddpTCZ+acjTXylazeucJF9jALRPWQwnYcgy3aeM9vbe1PLdQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10201
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 May 2024 05:35:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15868

Hi all,

CIP kernel team has released Linux kernel v5.10.216-cip47.
The linux-5.10.y-cip tree has been updated base version from v5.10.214 to v=
5.10.216. This release also includes patches for the Renesas ARM64 SoC RZ/G=
3S.

You can get this release via the git tree at:

  v5.10.216-cip47:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      91af320f42aad5646d0832d1627aca3f0964b284
    Fixed CVEs:
      CVE-2022-38096: drm/vmwgfx: Fix possible null pointer derefence with =
invalid contexts
      CVE-2023-28746: Register File Data Sampling (RFDS)
      CVE-2023-47233: Use after Free bug in brcmf_cfg80211_detach
      CVE-2023-52458: block: add check that partition length needs to be al=
igned with block size
      CVE-2023-52482: x86/srso: Add SRSO mitigation for Hygon processors
      CVE-2023-52488: serial: sc16is7xx: convert from _raw_ to _noinc_ regm=
ap functions for FIFO
      CVE-2023-52614: PM / devfreq: Fix buffer overflow in trans_stat_show
      CVE-2023-52620: netfilter: nf_tables: disallow timeout for anonymous =
sets
      CVE-2024-24857: Integer overflow bug was found in bluetooth device dr=
iver
      CVE-2024-24858: Race condition bug in bluetooth driver causes DoS
      CVE-2024-24859: Race condition bug in sniff_{min,max}_interval_set() =
in bluetooth driver causes DoS
      CVE-2024-24861: Race condition bug was found in media/xc4000 device d=
river in xc4000 xc4000_get_frequency()
      CVE-2024-25739: ubi: Check for too small LEB size in VTBL code
      CVE-2024-26642: netfilter: nf_tables: disallow anonymous set with tim=
eout flag
      CVE-2024-26643: netfilter: nf_tables: mark set as dead when unbinding=
 anonymous set with timeout
      CVE-2024-26654: ALSA: sh: aica: reorder cleanup operations to avoid U=
AF bugs
      CVE-2024-26687: xen/events: close evtchn after mapping cleanup
      CVE-2024-26810: vfio/pci: Lock external INTx masking ops
      CVE-2024-26812: vfio/pci: Create persistent INTx handler
      CVE-2024-26813: vfio/platform: Create persistent IRQ handlers
      CVE-2024-26814: vfio/fsl-mc: Block calling interrupt handler without =
trigger
      CVE-2024-26817: amdkfd: use calloc instead of kzalloc to avoid intege=
r overflow
      CVE-2024-26922: drm/amdgpu: validate the parameters of bo mapping ope=
rations more clearly
      CVE-2024-26923: af_unix: Fix garbage collector racing against connect=
()
      CVE-2024-26924: netfilter: nft_set_pipapo: do not free live element
      CVE-2024-26925: netfilter: nf_tables: release mutex after nft_gc_seq_=
end from abort path
      CVE-2024-26926: binder: check offset alignment in binder_get_object()
      CVE-2024-26931: scsi: qla2xxx: Fix command flush on cable pull
      CVE-2024-26934: USB: core: Fix deadlock in usb_deauthorize_interface(=
)
      CVE-2024-26935: scsi: core: Fix unremoved procfs host directory regre=
ssion
      CVE-2024-26937: drm/i915/gt: Reset queue_priority_hint on parking
      CVE-2024-26950: wireguard: netlink: access device through ctx instead=
 of peer
      CVE-2024-26951: wireguard: netlink: check for dangling peer via is_de=
ad instead of empty list
      CVE-2024-26955: nilfs2: prevent kernel bug at submit_bh_wbc()
      CVE-2024-26956: nilfs2: fix failure to detect DAT corruption in btree=
 and direct mappings
      CVE-2024-26957: s390/zcrypt: fix reference counting on zcrypt card ob=
jects
      CVE-2024-26958: nfs: fix UAF in direct writes
      CVE-2024-26960: mm: swap: fix race between free_swap_and_cache() and =
swapoff()
      CVE-2024-26961: mac802154: fix llsec key resources release in mac8021=
54_llsec_key_del
      CVE-2024-26965: clk: qcom: mmcc-msm8974: fix terminating of frequency=
 table arrays
      CVE-2024-26966: clk: qcom: mmcc-apq8084: fix terminating of frequency=
 table arrays
      CVE-2024-26969: clk: qcom: gcc-ipq8074: fix terminating of frequency =
table arrays
      CVE-2024-26970: clk: qcom: gcc-ipq6018: fix terminating of frequency =
table arrays
      CVE-2024-26973: fat: fix uninitialized field in nostale filehandles
      CVE-2024-26974: crypto: qat - resolve race condition during AER recov=
ery
      CVE-2024-26976: KVM: Always flush async #PF workqueue when vCPU is be=
ing destroyed
      CVE-2024-26978: serial: max310x: fix NULL pointer dereference in I2C =
instantiation
      CVE-2024-26979: drm/vmwgfx: Fix possible null pointer derefence with =
invalid contexts
      CVE-2024-26981: nilfs2: fix OOB in nilfs_set_de_type
      CVE-2024-26984: nouveau: fix instmem race condition around ptr stores
      CVE-2024-26988: init/main.c: Fix potential static_command_line memory=
 overflow
      CVE-2024-26993: fs: sysfs: Fix reference leak in sysfs_break_active_p=
rotection()
      CVE-2024-26994: speakup: Avoid crash on very long word
      CVE-2024-26997: usb: dwc2: host: Fix dereference issue in DDMA comple=
tion flow.
      CVE-2024-26999: serial/pmac_zilog: Remove flawed mitigation for rx ir=
q flood
      CVE-2024-27000: serial: mxs-auart: add spinlock around changing cts s=
tate
      CVE-2024-27001: comedi: vmk80xx: fix incomplete endpoint checking
      CVE-2024-27004: clk: Get runtime PM before walking tree during disabl=
e_unused
      CVE-2024-27008: drm: nv04: Fix out of bounds access
      CVE-2024-27013: tun: limit printing rate when illegal packet received=
 by tun dev
      CVE-2024-27020: netfilter: nf_tables: Fix potential data-race in __nf=
t_expr_type_get()
      CVE-2024-27059: USB: usb-storage: Prevent divide-by-0 error in isd200=
_ata_command
      CVE-2024-27437: vfio/pci: Disable auto-enable of exclusive INTx IRQ
    added commits:
      CIP: Bump version suffix to -cip47 after merge from stable
      arm64: defconfig: Enable RZ/G3S (R9A08G045) SoC
      arm64: dts: renesas: rzg3s-smarc: Enable SDHI1
      arm64: dts: renesas: rzg3s-smarc-som: Enable SDHI2
      arm64: dts: renesas: rzg3s-smarc-som: Spelling s/device-type/device_t=
ype/
      arm64: dts: renesas: r9a08g045: Add missing cache-level for L3 cache
      arm64: dts: renesas: r9a08g045: Add nodes for SDHI1 and SDHI2
      arm64: dts: renesas: Add initial device tree for RZ/G3S SMARC EVK boa=
rd
      arm64: dts: renesas: Add initial device tree for RZ SMARC Carrier-II =
Board
      arm64: dts: renesas: Add initial support for RZ/G3S SMARC SoM
      arm64: dts: renesas: Add initial DTSI for RZ/G3S SoC
      dt-bindings: soc: renesas: Document SMARC Carrier-II EVK
      dt-bindings: soc: renesas: Document RZ/G3S SMARC SoM
      dt-bindings: serial: renesas,scif: document r9a08g045 support
      dt-bindings: mmc: renesas,sdhi: Document RZ/G3S support
      pinctrl: renesas: rzg2l: Add RZ/G3S support
      dt-bindings: pinctrl: renesas: Document RZ/G3S SoC
      pinctrl: renesas: rzg2l: Add support for different DS values on diffe=
rent groups
      pinctrl: renesas: rzg2l: Move DS and OI to SoC-specific configuration
      pinctrl: renesas: rzg2l: Adapt function number for RZ/G3S
      pinctrl: renesas: rzg2l: Adapt for different SD/PWPR register offsets
      pinctrl: renesas: rzg2l: Index all registers based on port offset
      pinctrl: renesas: rzg2l: Add validation of GPIO pin in rzg2l_gpio_req=
uest()
      pinctrl: renesas: rzg2l: Rename rzg2l_gpio_configs[]
      pinctrl: renesas: rzg2l: Make reverse order of enable() for disable()
      pinctrl: renesas: rzg2l: Make struct rzg2l_pinctrl_data::dedicated_pi=
ns constant
      soc: renesas: Identify RZ/G3S SoC
      soc: renesas: Use "#ifdef" for single-symbol definition checks
      clk: renesas: r9a07g04[34]: Use SEL_SDHI1_STS status configuration fo=
r SD1 mux
      clk: renesas: r9a08g045: Add clock and reset support for SDHI1 and SD=
HI2
      clk: renesas: Add minimal boot support for RZ/G3S SoC
      dt-bindings: clock: renesas,rzg2l-cpg: Document RZ/G3S SoC
      clk: renesas: rzg2l: Add divider clock for RZ/G3S
      clk: divider: Add re-usable determine_rate implementations
      clk: renesas: rzg2l: Refactor SD mux driver
      clk: renesas: rzg2l: Remove CPG_SDHI_DSEL from generic header
      clk: renesas: rzg2l: Add struct clk_hw_data
      clk: renesas: rzg2l: Add support for RZ/G3S PLL
      clk: renesas: rzg2l: Remove critical area
      clk: renesas: rzg2l: Simplify the logic in rzg2l_mod_clock_endisable(=
)
      clk: renesas: rzg2l: Use core->name for clock name
      clk: renesas: rzg2l: Simplify .determine_rate()
      clk: renesas: rzg2l: Use u32 for flag and mux_flags
      clk: renesas: rzg2l: Convert to readl_poll_timeout_atomic()
      clk: renesas: rzg2l: Don't assume all CPG_MOD clocks support PM
      dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3S SoC
      dt-bindings: soc: renesas: Document Renesas RZ/G3S SoC variants
      clk: renesas: rzg2l: Check reset monitor registers
      clk: renesas: rzg2l-cpg: Reuse code in rzg2l_cpg_reset()
      clk: renesas: rzg2l: Fix computation formula
      clk: renesas: rzg2l: Use FIELD_GET() for PLL register fields
      clk: renesas: rzg2l: Trust value returned by hardware
      clk: renesas: rzg2l: Lock around writes to mux register
      clk: renesas: rzg2l: Wait for status bit of SD mux before continuing

Best regards,
   Nobuhiro


