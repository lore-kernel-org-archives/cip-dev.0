Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B5CC4345F
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 12:08:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.15264.1714046918575245853
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 05:08:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 43PC8Hg31095468; Thu, 25 Apr 2024 21:08:17 +0900
X-Iguazu-Qid: 2rWhGbqYi4MI5HJjf6
X-Iguazu-QSIG: v=2; s=0; t=1714046897; q=2rWhGbqYi4MI5HJjf6; m=Tt8MjY4fX9PMRNQLDPMGA9QjRyumgIbsodZ/tPXlRDc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 43PC8EcY3774006
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:08:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEX5LeyB5dCKXx6BrtCXlV8vd5MX5Ef+/IN/RgNkr5F25bvEpqc2g6Twj+H3MFfK1QbAglhwFI138IpSYmElPL7SeHHkGqOgnOVLDpey245gMRDM5tvwr6RWlOq+aMcZFH+2CtIcC51WN6Zu6ODc3MCV/BE1muHLtct8bEozlS0bDb8JjuiZEeubpYfjmM/QpslDCvrv2S/BP5JaGLTeklAmSVo4gR0fEdl8FvmZcWNubVc3whqGYbjAj5YawJtwIQSg2JmeusOuhMlLAUe40DsNc7h3TLACT9wahoYGrjt0teFyCg4nGln3IwItflGAaCI8h3RP3k5sHt87R2T/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3R/CVEc6gGJmlvgZCBYbMZdNnC997d84nz5iQcHUgBc=;
 b=kRoU2aQy2f9YrxtfftCBRP9wGsKwUJX8cvzTgRIPAZOdeliFRovRT10AyQqbQhiS9gtQ4CTarrCS7B2fOd4A5+RxTVBXSTmQURquK6DdsNQ//6jC0cUBnnKRBpdQxK2KyRc08BbgrBTMo8hFAhR2wEXyY501uQ78EXevLB2H5xsiXWBX2+oDOg6ZSA2G/oa4/sDfDbKKcfT8F/3PTwWHxoZIAhvQyd4DvkLWXzgpM+4yYM/nWxnXIdrLDltvrX1+5Jzxz+/3+UWy3n9MffEne4QLsIDt4se8Ze+e6cp2xKC0Mn0i7jUVzKIJzcxKAtTMBLX9Ixc0gd8bX8fNjUUGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.312-cip109
Thread-Topic: [ANNOUNCE] Release v4.19.312-cip109
Thread-Index: AdqXCTMwu2LnDZlERAS5tEVPLhPMHA==
Date: Thu, 25 Apr 2024 12:08:12 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388B4CAEBA584B6B16043CA92172@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS3PR01MB5608:EE_
x-ms-office365-filtering-correlation-id: c42c27de-a232-48c6-0e68-08dc65206178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|1800799015|38070700009|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?d3BOZXIyQWpEWWErYlIyQXFzblFrTXJCTks2TCtTQ0p4UUY5MlRWYTgy?=
 =?iso-2022-jp?B?c3dzdVZ2aG9OYktzUlg5anhvUjhoNTQ0VVgrVGRqbHo3ZmdGa3VCZHhn?=
 =?iso-2022-jp?B?ek1nbExIaEpNQ21lMHhzaVVhMU9TMkRVanRSNTg2akV5L3VmeDRhbzRq?=
 =?iso-2022-jp?B?dW95NFFLcWRsVFNhY2xpU1VlMm9zcVlXYWJ0azR4UUh4Z0NkN0wzQ3dI?=
 =?iso-2022-jp?B?cnlqbWk2eER3aU91RFdhV04zSE8xRy9tNzNGek51Znk5KzJwZEhOSElh?=
 =?iso-2022-jp?B?Rkl3bHhvUUE0cUZNL3ZJVmFCcGlKME52WENnSUtBUGpEdUZsb2lBaW9Z?=
 =?iso-2022-jp?B?VUxSR0dKMEc5a2tGdUNZMkpIc1BldmlwNUdqWFpjTWZHSVRkOXpVVW00?=
 =?iso-2022-jp?B?VTQ1L0FnbUtLNmlxRzFOcTJyTE90ZmNCWjNITk9PZitzK2tsQ1pybTUy?=
 =?iso-2022-jp?B?YnBPUk9zSkNaTWdQUWZGVDNrRmh1RVlWK3loNm5QNkk1SVZSdGJSRjBP?=
 =?iso-2022-jp?B?aUFNUnczZnYrZEFRd282bDdmTGl3ZndlczU3V2UxeEZQVWoySE8zUHE3?=
 =?iso-2022-jp?B?YWtGeTlNWmJ5Umt5K2FLeEZQVWxWUE85Tm1ldzdXa3NCVFpuVTBuMDJJ?=
 =?iso-2022-jp?B?b0ZUeGNaSkw4SEVUS1pyRlFQZFZ1WUZyK3M3QXpBbG53K1Rsa3lta2pD?=
 =?iso-2022-jp?B?Zkprd0taVmVWTjV5WVNCZFo3UCtLSnNZZFZiSGFObkh0NmY4R1d5SHls?=
 =?iso-2022-jp?B?NlVTN1Y5MzJ3Q2pNbzg5blA5N0dLQ01RYVE5RmlUR0NLZ0xveDZuUnVr?=
 =?iso-2022-jp?B?SE1XY2hMQWRhYys0dUxRWDJUbldJRUQrUkNGanNIcTQvTzRuMlB2Sk5B?=
 =?iso-2022-jp?B?UVhSSGtDbkNnd3FOWTR4Vy9JVk5WaXJQai9nb3NGQ3JmMEVlMmwrYlpN?=
 =?iso-2022-jp?B?WVhZc200ZWRUV0JQaGxXU2FDb2Uxb0l6RjJEYWJnTkdKRlY1a2x3Zm85?=
 =?iso-2022-jp?B?RTdibDBWNWUrWk5WWHM3bDlrM211RG5zV2dibVhPRU5lYWNOTnl4d21R?=
 =?iso-2022-jp?B?akdhek5PNEdYYjA4Njkxb25RVHIzKzNka1d0bmRWT0VHb3FEdE03enJP?=
 =?iso-2022-jp?B?OFdrbDZacWFiTWxHbTZsRmhiUXFIc0ZZY0djYmZYazdaYmlSNjljN01a?=
 =?iso-2022-jp?B?NjRjMTdncUJRVUt3cVlUY0ExWDlMaVlMUHNYTjNyaGl3Sm12eFhOUkR2?=
 =?iso-2022-jp?B?MkRxRGZmQk5ZTDAzd0t6cnlKYmtSdXF0dXl6SWZUd2xlNmVBQUZOakhK?=
 =?iso-2022-jp?B?NWpQbW1jYUswRFk5WVlhVVdodHEyczVsSXd2blR3enJSN2V2cHZ3Nm0r?=
 =?iso-2022-jp?B?TEpzYnVmRjExTlROaUdsTWRLcVVMNWVmVlZSUlE0YXp0VVRXbHNuQ3ly?=
 =?iso-2022-jp?B?TnJVd2xrSXM2WFQ1TEZaTFd6NDhObTZiZzFWWk41MEo0aklBRjM2UTA0?=
 =?iso-2022-jp?B?bTRpdDJycHgvQkFyNUc3ZXRuem5UcVFZUVZFSXkwMThTcnI5Q3NlZHBW?=
 =?iso-2022-jp?B?LzdmRjc3dUlkdkNtanh6WGpJSXRvbE9ha2hta21GQWw0ZU9vRFB5QTdh?=
 =?iso-2022-jp?B?UjV6dkJLSE8xMkU0R3RPbGtac0tmNXcvV0Q1UUVmQjV6VXlYS0p3Ulpt?=
 =?iso-2022-jp?B?ay9kSGZ1eDRHRmxHTWJOOUQrUG5oZHBlVU9uMGZOVVhrblJkM1pJSGFs?=
 =?iso-2022-jp?B?K3BZMDRPYTZMZDBnTHR3TW8rZE1yWDFlZUVIRHViYWhFZk50NmY0NlZL?=
 =?iso-2022-jp?B?YnFjWmFLdzRTbzNyQWtmb0Y0WUJCMGRPZEhuTjZxR3VPaDhkcEJ0dStC?=
 =?iso-2022-jp?B?SWtvOEw3alJ6Umsrbjk1T29pSmE5bXNXMXFrN0NRckVUVzRLT09JdEVD?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VnFRM3ZHQVF4VVNwWEk1MUVWWkM4d1NiRWx2MHZNZW1lckszSHU5SGRj?=
 =?iso-2022-jp?B?MDlLZGdUN2I5T1JhMHY1VzBycy9PMlJtVTdnTXV3K3ErOTNlWUpxdWRz?=
 =?iso-2022-jp?B?RWYxTnBzSEFWRlliREpuMzlHSEh1YjJZemlCVHB6aWtrVmxZOUJzNjlj?=
 =?iso-2022-jp?B?Rkd1NTludU56WkdUSHlidnk3WnZlUGo1TWkxTll3VjdZYXZTWDBvdjZK?=
 =?iso-2022-jp?B?THBicWxMeVkzK0N4YnJzRGxDaXRZelhqSGZZdmFDQTdZK0lGZEdqYVNn?=
 =?iso-2022-jp?B?RUZPV1JDRUtvOU1ZcEdCekhFZFR5YVg3VTFCeHF1dndQUjVRbTNFV05R?=
 =?iso-2022-jp?B?TUNuL1RWajlIeVppL09uSkEzSFpRcmFTdTkzVHBXSmlhR1pMbHZveTd1?=
 =?iso-2022-jp?B?SWJxT0NlS243TXdlNkFMUXFwc0RFNy8rbW9kUm52ZUExeUtQUVdFaWhp?=
 =?iso-2022-jp?B?REpqbHdmVzZ2YUsrdmZoWDlhTFlWc25KaHpwUU4xMVlTeDhKd2REZldw?=
 =?iso-2022-jp?B?czcxVzUwelFsN2owMFprRUdwQjRPMUtJcHc2SXJaeTg0eWxDWWRkcE9B?=
 =?iso-2022-jp?B?bk1iSExtY042Z3BVWXJrdVk4dkxlNHNVeU83blNPL2p2aDlTaWVPeE1F?=
 =?iso-2022-jp?B?czVGVGtwUm1XV0lacVhyZzdtenFlMjRIb1dpQ0F0QllTVlZXRC8xaExO?=
 =?iso-2022-jp?B?cEtGNlRJVExWdmo4cmpNZXFjWVlvN0RGV1g4THlOMEs2di9uaExKNGd3?=
 =?iso-2022-jp?B?dXZkTlhLMUZWM1JZNytzeE1TemlhZlB3cHFIQWhPcmNrTCszaGRxZFZk?=
 =?iso-2022-jp?B?dFFoMWFMcENxVm01UVpsWFNsekcvY1R6bGdHM0NCSVVDSWpHNGJjTDEz?=
 =?iso-2022-jp?B?WHROK2ZMZS9rMm9PTUVJS2tkWm5ZSVBleThXb0FCcmpSTUJLZE16WWFM?=
 =?iso-2022-jp?B?RXJSTDFvM3VCdXplQTlZbFFPYWJubzZCVlI3ems2L3NLZktYT1VHYVJs?=
 =?iso-2022-jp?B?Y0tOOWhhb0ZqZ2k3eE1RSEs0SGRFQUFYeDF4eGFaY1FyeFFBM0I2RjdW?=
 =?iso-2022-jp?B?M3lYYm1wK2ZlcFlrYjR0Q2ovZGppd1ZZVnBtR25kd0k4N3JaSENQdWxG?=
 =?iso-2022-jp?B?d3NkUjZ5N2o2NmZ4Y1F5OWM2aC9tMml3Y2l4L3JLRi9Oak04czF4SjBD?=
 =?iso-2022-jp?B?Q0dnN1NLQTBLdGZtNFRUMkdFNEFkMTVyOXJvSjVqOG5NS2J3dXFPa3ps?=
 =?iso-2022-jp?B?U2VHUnZhZ24rTVcvWmJmSEdVQnA0TjJ0M3JMZDdYb0ViOTVkZXlZd1RE?=
 =?iso-2022-jp?B?REdOa1dTSFFPa0kyOGxTV1IwSkRkeHlwaXFzT3FGQ1FSRit1UW9zZXds?=
 =?iso-2022-jp?B?Y1d6Yk9vY29FSkF2ekZKY2VNMTl5TGNKTm5scElDMVlrNjZPZkZpZ1pk?=
 =?iso-2022-jp?B?OG1hRVhKeUw1aDJkQXM1UDcxV3dLZ1loeGt1b2Q4VXQzWkM2V2dQbVUz?=
 =?iso-2022-jp?B?aHlmZUVYQW91dVlhTGdNTnNndXEvVlBqWlY1eDUzTVpjRkp5Y1Z5RWFB?=
 =?iso-2022-jp?B?NGRHalVtcFdwSGxPVW9UcjlEcTU3TDRsQTdUZm80clJtYjJpWjd1VWFB?=
 =?iso-2022-jp?B?VkZNZTFBUFk1eHhUc0pIN0hjOXQxUXgyVnBzZm1jQ1RCbVVlbFQ5T0ts?=
 =?iso-2022-jp?B?QlJzblFVRGh3ZkZOQmFKYUpRZU9LVzM0Q09xYjhIYnQrcHBPTnZsNVR0?=
 =?iso-2022-jp?B?MXlQNFNIMDVCSmR5eWVEL3liZ012eG4xS0g3M0NOckhEbDR4RGxMdDRH?=
 =?iso-2022-jp?B?ZThnVDBrTUdOVFI2V3llSndlY2YwU0R0MU85RHZDWDFjOGpscEt6R0NM?=
 =?iso-2022-jp?B?Um5YZS9lNklNK05nQVlydFJQWS9STjY2djZ6ZE01eEtLSnlmaWdIM2kr?=
 =?iso-2022-jp?B?RTZpcGhWd1pzcWROYkVzSFY2UG1vNjlheWtMdFBxVERUbjU4bW1KQStC?=
 =?iso-2022-jp?B?Z1M1akptRkpWeENoaTFTRXFvUW5HTEMyNi9QUkRhcGZQayt0b0V2c2wv?=
 =?iso-2022-jp?B?eVhraWxXaHFDMXNiQytEKzhqZjRnZ1JSUm5PeDNQcmw3aGh6QzNvTnIz?=
 =?iso-2022-jp?B?M1F6YUwvcTk2ZmRaR2ZETkdXOWVCaXU5UlI2QVdwZ2txRDN3SjF0bE1l?=
 =?iso-2022-jp?B?dDkvUjI2Y1BKR2l1Mnc0MWpsZEo2d3RreEFtRHNtcUNnVlJpQ001S2lD?=
 =?iso-2022-jp?B?T1Y5MlVuNE9VUHEyUndBUzdNYVUxSTlTL1g5UVRpaExicDNWMmN5Vkc0?=
 =?iso-2022-jp?B?TGIrYlFzZzMzeHVWWXozRlE2eVN3RUpPWFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42c27de-a232-48c6-0e68-08dc65206178
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 12:08:12.8356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUNdoUPciB2uKBh0d+P+CD+UGIkmwP2smzlR77Et+A5pUWqqmAWFsyaYPKTjCLIvxABJWm7wLifMXFcYjHCdbTlP9InhxGBz9nGNWQ9JflPjBHy17hApAfV/YIoDTIVf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5608
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 12:08:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15762

Hi,

CIP kernel team has released Linux kernel v4.19.312-cip109.
The linux-4.19.y-cip tree has been updated base version from v4.19.310 to v=
4.19.312.

You can get this release via the git tree at:

  v4.19.312-cip109:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      959de52810ed02ef75efb3d00ed0b01718396700
    Fixed CVEs:
      CVE-2022-48627: vt: fix memory overlapping when deleting chars in the=
 buffer
      CVE-2023-47233: Use after Free bug in brcmf_cfg80211_detach
      CVE-2023-52620: netfilter: nf_tables: disallow timeout for anonymous =
sets
      CVE-2023-52644: wifi: b43: Stop/wake correct queue in DMA Tx path whe=
n QoS is disabled
      CVE-2023-6270: AoE: improper reference count leads to use-after-free =
vulnerability
      CVE-2023-7042: wifi: ath10k: fix NULL pointer dereference in ath10k_w=
mi_tlv_op_pull_mgmt_tx_compl_ev()
      CVE-2024-22099: NULL pointer dereference bug and buffer overflow vuln=
erabilities was found in the bluetooth subsystem
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
      CVE-2024-26651: sr9800: Add check for usbnet_get_endpoints
      CVE-2024-26654: ALSA: sh: aica: reorder cleanup operations to avoid U=
AF bugs
      CVE-2024-26816: x86, relocs: Ignore relocations in .notes section
      CVE-2024-26817: amdkfd: use calloc instead of kzalloc to avoid intege=
r overflow
      CVE-2024-26820: hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_=
REGISTER missed
      CVE-2024-26851: netfilter: nf_conntrack_h323: Add protection for bmp =
length out of range
      CVE-2024-26852: net/ipv6: avoid possible UAF in ip6_route_mpath_notif=
y()
      CVE-2024-26857: geneve: make sure to pull inner header in geneve_rx()
      CVE-2024-26859: net/bnx2x: Prevent access to a freed page in page_poo=
l
      CVE-2024-26863: hsr: Fix uninit-value access in hsr_get_node()
      CVE-2024-26874: drm/mediatek: Fix a null pointer crash in mtk_drm_crt=
c_finish_page_flip
      CVE-2024-26875: media: pvrusb2: fix uaf in pvr2_context_set_notify
      CVE-2024-26878: quota: Fix potential NULL pointer dereference
      CVE-2024-26880: dm: call the resume method on internal suspend
      CVE-2024-26883: bpf: Fix stackmap overflow check on 32-bit arches
      CVE-2024-26884: bpf: Fix hashtab overflow check on 32-bit arches
      CVE-2024-26889: Bluetooth: hci_core: Fix possible buffer overflow
      CVE-2024-26894: ACPI: processor_idle: Fix memory leak in acpi_process=
or_power_exit()
      CVE-2024-26898: aoe: fix the potential use-after-free problem in aoec=
md_cfg_pkts
      CVE-2024-26901: do_sys_name_to_handle(): use kzalloc() to fix kernel-=
infoleak
      CVE-2024-26903: Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check=
_security
      CVE-2024-26908: x86/xen: Add some null pointer checking to smp.c
    added commits:
      CIP: Bump version suffix to -cip109 after merge from stable

Best regards,
   Nobuhiro


