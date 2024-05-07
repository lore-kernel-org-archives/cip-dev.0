Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24100C10F1A
	for <webhook@archiver.kernel.org>; Tue,  7 May 2024 12:50:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.10697.1715086235806799390
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 May 2024 05:50:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 447CoHA4284730; Tue, 7 May 2024 21:50:17 +0900
X-Iguazu-Qid: 2yAbLYkr5YAlqSbbZQ
X-Iguazu-QSIG: v=2; s=0; t=1715086217; q=2yAbLYkr5YAlqSbbZQ; m=Mesf1oUpb0FLLAFJQz8n2XlfOmSv9z1h446K3qNugIM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 447CoFis1159210
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 21:50:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xpi/M4V6fpLrMQEARmGazuBIu4gpvDmqW07Ro7DgHEnFPHvdRWEOKi9GhyEVhXBPJ1Odj/F+CUfx58EQ3NvVmx774/Whpw13U7DAhwaP3hlZQR4Dp21QDf662Uzn9tQGFz4hO2X3Vk0Fs6RIFDnCrJQRUaW1npD1w/UuxMJKGjTJwmCvEfO3l0r7AHqNuwa5Ntl1SeCdVUpI30CmSdR35zS3XUJSV8huxCOuIa0ataVFtsk+mKHxkOKL8KqFcUa4pSYGk+QcHIsDFT1eAwIbfcHSq29c3H8X6Pu2IPPH6QdzxMPG3BXVjTXyqtono+iCT7G70m14ilVyLuOGleF1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YX+bb+SaCuJpYwl3oVzubS9v/38EXFlMf5849PPAjcI=;
 b=f7RRGCNR0ir6I1XE0L8hUm/9GsMpvnfq7/l4mBgAlI3lGRnVCLcQs+ruWc54hWNik77wgYE8iBHE0ckFFaZnClzkVr38hK+2F3U8LCP5vM7sn7/qsAZwYQwbE2andzJUU0Dx/RlyjMYl/cQm46vBbL45q4JF1S2XcwSguZUn39DOwDPGOu2IfEn9wh4xrJ1jJpcXxnC+/JY50wT7RxjHE1IFCGCYl5CEfIeClJbzcyR82zIzmGvIeuVK6+NLGcrYpio7ne69f3qjh7hX2tpbvHxPaAjd7PJM4TeLmf/FXxGmKkCAf4A1xYNLv6ZMNhQMeBSch8fk0cdYghtZ/LLj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.90-cip20
Thread-Topic: [ANNOUNCE] Release v6.1.90-cip20
Thread-Index: AdqgfQ3C2gFmSs0gTliungbRa026VQ==
Date: Tue, 7 May 2024 12:50:12 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63887B0E8A3B7B906381244E92E42@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB7939:EE_
x-ms-office365-filtering-correlation-id: 77ea9f2a-19e5-4ab6-f9cf-08dc6e943c1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|376005|366007|38070700009|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MkVpR29oK2N0cHR2VkRtaGlpN1pQQ2RNMFRDYVNEWlU4UkxlRXJSUnpJ?=
 =?iso-2022-jp?B?aXdFZkxkTzd1TXlmd1lIU2RVQTVKM3BLRzhPbHduZllQR1J1VW9RUGFp?=
 =?iso-2022-jp?B?NGtjRzk1V3RpTmdoUXJlOTFlMjhWMDFEWVJQQ3UrL2tLM2xkbTIyT250?=
 =?iso-2022-jp?B?Z0lVY0ZGMjhUd2RUQnRhbDlzSThZbit1NzkvcEdPWFF0WWh0UlByd2k4?=
 =?iso-2022-jp?B?eEEyL1p4Qktyb3plbUR4R2YxWVYrU2VVdmQyeGFBNnhPWHZaeTNIQlRG?=
 =?iso-2022-jp?B?NFh3TUVsMDM5dXFiaFYwQjVjUGF4ZXpjSXVHWGZvMExuaURTNWxNNEJ4?=
 =?iso-2022-jp?B?QXJxSWNQODM4QVNrYVE3THBCSjRFZHF5VkVxMDlTMFMzT3ExZVgrcEJY?=
 =?iso-2022-jp?B?MTU5U09kNDNBV1diaGs4RFRUTEZESHBBdkRNY0ZSOG9LSGNYWG44Z2Nl?=
 =?iso-2022-jp?B?RFdvNmptN0lLL2FGVHVtZ0RjYWFDMEoxelpBMEpsb2QvSWpmNnhiTWNq?=
 =?iso-2022-jp?B?VXFLMjFmSVFzWUVrTzRvR1ppTythZkdETGI0K25obFBUWnVoNloydEdJ?=
 =?iso-2022-jp?B?REVoNXRNbTJJK2FMMDR5TDFjUFgxQWk1K0VhVkpaQzJseWtveHR2dE50?=
 =?iso-2022-jp?B?VzA5ZUhlaFdrNmFHYmsydUljajAwNHZiblZ2Y1pXUDA5OGJkY1NHMGpM?=
 =?iso-2022-jp?B?V3gzS2VtbEloUjU2cmxmZnNkWXBhR2E0TUcrWTdaYWFVME84eFZ5UjZR?=
 =?iso-2022-jp?B?NVhQejQraWRKVnJ0V05yK2dFeitYNmlFUVNpcC9kdGJYY3lBV3FLSGU0?=
 =?iso-2022-jp?B?Z2JGTjlCbUxTK1JLdFdnOHdYRUV3MVZ5U0l2Rm1jMFdhRkZmcFFySmgz?=
 =?iso-2022-jp?B?dy9CK2FtblRVUW01Smk1ejhKdG9naTh5S3BtU0lUMVZYWFVlVXMycWZ6?=
 =?iso-2022-jp?B?VXRvMTN6bGF3UUU5RFljZ3B0azVsYmUzMUZkWXhDWGtUendtaC9LbHVV?=
 =?iso-2022-jp?B?QitjRm9kSHQwTGxNS1lqSkMydHBVSWF3eUFJZjNxRmtMVWIyTUJxVWFX?=
 =?iso-2022-jp?B?VHlNdjlkMVRHckYzMlFiTnZKa3NvODJiSE1IRTZrdEM3V0FNZEszKzg3?=
 =?iso-2022-jp?B?blpnNU9PQ1hHcmJVTWJWOUp0VXpMSkprOFBRd0NDa1EwYTErQjhyREVn?=
 =?iso-2022-jp?B?WjBJTHRUV0E0TnVuVFRVY1pPNkkzRmo0L2dYY2ZpUDFGNnQzMFRXRUVm?=
 =?iso-2022-jp?B?bXV4RUpyOEM5YWhHLzd2aEQ2MGU0UjF6Nkw3d04zakoxM2pmU2tLNnNk?=
 =?iso-2022-jp?B?LzI3emkrdTdGN2t6Y3BYWFU4OVlKaUU0bjR4clNySlhXbDNlcmI5Wm5I?=
 =?iso-2022-jp?B?eG1jTTRmSUpXdEl5ZDFlL2NPN0M2cFBLdlhsVFdTMTMvRWN3R1ZkR0Z6?=
 =?iso-2022-jp?B?Y05DZDM1UWFqSG1GK0xPL3NibWxlbThpd2VmTzF1RmFJV2duN1laV2pX?=
 =?iso-2022-jp?B?Nmd4MU8yNTZVRHpZdE5uZmtTTThvVVduek43RjRoeE9XWDlhZ3gyTlpo?=
 =?iso-2022-jp?B?MUtJcWpFQkpsdWo4dGZhVy9YRjAvZzlLUC91YjdwRllwQ0d4cGRDNU5Z?=
 =?iso-2022-jp?B?VElaYXA0TTc5NlUvWGFqaHIxVmVaVHJoV2xBSGZBSjRuZDBMdVN2OVd2?=
 =?iso-2022-jp?B?OWRyR084Tm1sOWV1enRoMEk3eWJlQm1NVGd3OWtUZlNXOWxuU013Z3ZC?=
 =?iso-2022-jp?B?U3hLMUtrMjd4WnV1LzJOdWlXRzJpM3cxWFVVbGxQaXdET2l6OGMzaHVT?=
 =?iso-2022-jp?B?eCtndytEKzU1UXRsd1ZOV0dMN0NJMlRFRWVMNEUrWFVlQnViL1FYM2VB?=
 =?iso-2022-jp?B?SUVEZkJRMGVHMlVRQ2MzZzNCZjJkS1paS1ZyMEs1SUV6ZHVOdzZYK1ha?=
 =?iso-2022-jp?B?djhNejlOM2VWdkQvVFFENzM5SU5iYVRNSVJ6eUtJcm5qUlIxSHQ3MStI?=
 =?iso-2022-jp?B?az0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TGFqbDN0cW15OFZIK0FYanJZUGxXSnNBdHE1TXZtN285Y1E5NGYrU2Ez?=
 =?iso-2022-jp?B?dXJXaHIvaks5QUpsQ0E4WmM1Vit4d0xhWjlGczJ3aXR6KzYxSStQM0E3?=
 =?iso-2022-jp?B?R3lvaC8xdnFPMEhDcGs1d09GTEtVY28xV0dVQndpNmZrbTlwMjkvT0RY?=
 =?iso-2022-jp?B?QkwvUHlPbWlYbjFlek01d240UVhmbU5VV2RtY2NHbGdwcUZja1E2U1Fs?=
 =?iso-2022-jp?B?ejV4aVRXZkViL1JyTVVkeU5hTkt3VnhqNEdzM0tuK0Z0ZERwalVjRFJv?=
 =?iso-2022-jp?B?RnFHeWdkeHhrSDQyTm16Y1JQTGVFeHN3OE45NFJWS1YvaGkxNDFHdGZ5?=
 =?iso-2022-jp?B?WGNONnFMOWI5cHk4NUk3QS8zSkFGQXpVSWJZRTh4VDVQMWgzVnM3ZWdF?=
 =?iso-2022-jp?B?T3JQUlpLamJiZDZhdGwwQ1FIRFRwOUJ2b1UyUHVnUTJvTEJxaUhCRnlI?=
 =?iso-2022-jp?B?K3Bzb1FrTVJhWmUvN3dJMTgzZzhCSUhUQnpSL3FOUkhkbXdkV3F5R054?=
 =?iso-2022-jp?B?ZzFjUGNXb0M2SFZ1cm9GcEJtVngvUml4ZHMyWGdlQ0M2Q29IN3A2MzJ5?=
 =?iso-2022-jp?B?dkxjaGpPQlVnaS85VjdIUnc2V2J1QW9qUEh3VnRuYWRsY1FidnZJbFkx?=
 =?iso-2022-jp?B?UDZ0YVNlSXBoNEE0elRGSCtSOG1nVktWZURXa0pyM3JKSUErU0V5VzVx?=
 =?iso-2022-jp?B?dk9WVTJNTzZXSzBJcVhjU004SFFWNDU3N2M0WXRPWEl3YXdnT2VyQkZr?=
 =?iso-2022-jp?B?Yk1NVUg1QVJOR1VRZWMyZ2RUTDI4blFNRFlNeFBaK3Rlc0tuN0s0dk1x?=
 =?iso-2022-jp?B?bzNNeU9DKytxKytXajRUR1QrTUZ1akdlMXR2QjRva2hxbmZyRXNsS2Z0?=
 =?iso-2022-jp?B?NVlvbGk3MnJRLzBZS1orY1hZM3NlVkJoQVo5eUIxN1NZRmFreTAyUGR6?=
 =?iso-2022-jp?B?alhjczl6aG9RSksxMjllcWRkQVFjNmNRdld4bGtNWXFVa1A5L0Y2U2dn?=
 =?iso-2022-jp?B?NGQrL1hNcC9lYmxCdFQrUTRHcUM5UTMwaE5PcTdoN2UyWlFrNCsyamNj?=
 =?iso-2022-jp?B?d29YU3FnUDc4M3M2OE1PUSt2SVpvYnRMdGZ0L2dZUSszNXQ0czdYdm9P?=
 =?iso-2022-jp?B?bGdRQUtqRGtnMk9JSlFSVnB1RFpGQVdqYWtLOEhuY0FoRXFpL1RsZ2lR?=
 =?iso-2022-jp?B?QUhocnEyMkxtTEQwU200Z2RhS0VUNlRjQ1RmZ3JYajlYYzJwbXFLc3Yr?=
 =?iso-2022-jp?B?UU9OZFpiV0V3U3d3Sm8rVC91Z2VDbVZtQ08zWWJxZ2plZHFIUzl1a0RP?=
 =?iso-2022-jp?B?ZmR4dlltdjc0cGlseisyK3ZWTDJxdHIzZU5NNUw3V2JDV0lmMURhVEky?=
 =?iso-2022-jp?B?ZW14OHRYUm8zSWhJVDkyZ0JUSnlDa0lNUEkwNTdKVkFsekRxWVk5cWNu?=
 =?iso-2022-jp?B?MUJ6K09NQW5qbGI1dWdkMFhVSjVvZFpCb29WMktobkJGR3BrT1VaL1U4?=
 =?iso-2022-jp?B?VHZsU1UrYzhXYXpBcnFDcjlMckJiRWdrQ0xMQTJCYlZJS2FONzEyT0Nh?=
 =?iso-2022-jp?B?NFpyR0NvMVlUZFBBTlFmYk5kdXViRStXKzFVdmkwQnZkVGdHdmlhbzBn?=
 =?iso-2022-jp?B?eFh1eDJoSW5VeHI4QXUrWThUY1E5aE9mekMxY1ZyTEFHQUFXNFg5aGNy?=
 =?iso-2022-jp?B?MldnZEFhNThDOUtKWUF4bCtwczJGTXlQem55OTZaeDZZTGlXUmwzQWxo?=
 =?iso-2022-jp?B?ZzZleVZwVThla1krbUlvOU02RGdwbUtDeTZ6UUNYSGxEQndZMmhmUk9O?=
 =?iso-2022-jp?B?Y2FqRjVmaHJZMkxlTjN4bEN3ZUw0SkhvQ29DOHFEMTRvc0ZPU2p2Sysr?=
 =?iso-2022-jp?B?aklISE9PR1Eyb0xvMVpaY3U1S25WMEN2UGdYVlV3RVR2NXYyVXVHcVZ1?=
 =?iso-2022-jp?B?ZDlFc1g1M2tOOEp4UlNVbS9PZVpsenRkM3lVaWtUQ2dWbnQzZFlKNDU1?=
 =?iso-2022-jp?B?WE03bldwN04rdm92Zk42OFUrTHZlTE4rdFdmMWN1aE9wY1U0dE4vT0Fv?=
 =?iso-2022-jp?B?N0Q5bFhYbjB1SDFGejkzS1YzeTZIaWZXVmNwNnRGdURNZzJYYjc3MU5i?=
 =?iso-2022-jp?B?K0cxT203MjdPVUxYdmQ3clRhcXcxTDF0YVhEaWdhMTNOejZobkE1aFp5?=
 =?iso-2022-jp?B?bUwvQkFNYStaK05kWEtHMWQ2NlZNNUNGTFJLZktTeW5GdUlEQXc0aS9w?=
 =?iso-2022-jp?B?b2paR3p1Qkx5bUhjT3Ewc1VTVUlxb25hY24vL0N5bE1wNi9GNjFoN1Mr?=
 =?iso-2022-jp?B?QllyZ1dVUi9XQm1hWlZVSVovS1FqUUl6M0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ea9f2a-19e5-4ab6-f9cf-08dc6e943c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 12:50:12.2325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CnN0QVA8/jBNf2wP4Uyfj6ziapoEFR1xHJFk88NurmLlZw/Ff//jPBSi/C1wMn1qSxS0rI0Yv1QUv7ef8d3LXZ5ciV/6GIoPKsqT+KY7iACq8oMZZQE9iobxCokvUru6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7939
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 May 2024 12:50:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15856

Hi,

CIP kernel team has released Linux kernel v6.1.90-cip20.
The linux-6.1.y-cip tree has been updated base version from v6.1.86 to v6.1=
.90.
This release also includes patches for the Renesas ARM64 SoC RZ/G3S.

You can get this release via the git tree at:

  v6.1.90-cip20:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      4e312831fe188da5bb477eeae886bcf07184f0eb
    Fixed CVEs:
      CVE-2024-27022: fork: defer linking file vma until vma is fully initi=
alized
      CVE-2024-27019: netfilter: nf_tables: Fix potential data-race in __nf=
t_obj_type_get()
      CVE-2024-27000: serial: mxs-auart: add spinlock around changing cts s=
tate
      CVE-2024-26993: fs: sysfs: Fix reference leak in sysfs_break_active_p=
rotection()
      CVE-2024-27009: s390/cio: fix race condition during online processing
      CVE-2024-26994: speakup: Avoid crash on very long word
      CVE-2024-26983: bootconfig: use memblock_free_late to free xbc memory=
 to buddy
      CVE-2024-26981: nilfs2: fix OOB in nilfs_set_de_type
      CVE-2024-26939: drm/i915/vma: Fix UAF on destroy against retire race
      CVE-2024-27003: clk: Get runtime PM before walking tree for clk_summa=
ry
      CVE-2024-27015: netfilter: flowtable: incorrect pppoe tuple
      CVE-2024-26996: usb: gadget: f_ncm: Fix UAF ncm object at re-bind aft=
er usb ep transport error
      CVE-2024-26922: drm/amdgpu: validate the parameters of bo mapping ope=
rations more clearly
      CVE-2024-26989: arm64: hibernate: Fix level3 translation fault in sws=
usp_save()
      CVE-2024-27020: netfilter: nf_tables: Fix potential data-race in __nf=
t_expr_type_get()
      CVE-2024-26997: usb: dwc2: host: Fix dereference issue in DDMA comple=
tion flow.
      CVE-2024-27018: netfilter: br_netfilter: skip conntrack input hook fo=
r promisc packets
      CVE-2024-26926: binder: check offset alignment in binder_get_object()
      CVE-2024-26984: nouveau: fix instmem race condition around ptr stores
      CVE-2024-26605: PCI/ASPM: Fix deadlock when enabling ASPM
      CVE-2024-27014: net/mlx5e: Prevent deadlock while disabling aRFS
      CVE-2024-27001: comedi: vmk80xx: fix incomplete endpoint checking
      CVE-2024-26987: mm/memory-failure: fix deadlock when hugetlb_optimize=
_vmemmap is enabled
      CVE-2024-26936: ksmbd: validate request buffer size in smb2_allocate_=
rsp_buf()
      CVE-2024-27004: clk: Get runtime PM before walking tree during disabl=
e_unused
      CVE-2024-26924: netfilter: nft_set_pipapo: do not free live element
      CVE-2024-27016: netfilter: flowtable: validate pppoe header
      CVE-2024-27002: clk: mediatek: Do a runtime PM get on controllers dur=
ing probe
      CVE-2024-26988: init/main.c: Fix potential static_command_line memory=
 overflow
      CVE-2024-26992: KVM: x86/pmu: Disable support for adaptive PEBS
      CVE-2024-27008: drm: nv04: Fix out of bounds access
      CVE-2024-26999: serial/pmac_zilog: Remove flawed mitigation for rx ir=
q flood
      CVE-2024-26980: ksmbd: fix slab-out-of-bounds in smb2_allocate_rsp_bu=
f
      CVE-2024-27013: tun: limit printing rate when illegal packet received=
 by tun dev
      CVE-2024-26923: af_unix: Fix garbage collector racing against connect=
()
    added commits:
      CIP: Bump version suffix to -cip20 after merge from stable
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
      dt-bindings: soc: renesas: Document Renesas RZ/G3S SoC variants
      dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3S SoC

Best regards,
   Nobuhiro


