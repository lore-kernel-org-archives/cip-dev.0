Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED872C25B77
	for <webhook@archiver.kernel.org>; Wed, 22 May 2024 08:08:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.4813.1716365299964811276
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 May 2024 01:08:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 44M88Hsg3787196; Wed, 22 May 2024 17:08:18 +0900
X-Iguazu-Qid: 2yAbXhlxOQdNJf5tBo
X-Iguazu-QSIG: v=2; s=0; t=1716365297; q=2yAbXhlxOQdNJf5tBo; m=+co3mZoYdvwOAOMgKNcZUZNpo1bc6dWjHGSOwXikmYs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 44M88GlX506145
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 17:08:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n27US/4B//877fNyTOWippaPx0nhidd0iVV4/y5Ih00ZrCJlSzwUiBoQgmkFL0feX8uFoDDZHTljHQNEGOUg69mKzkisbin0/C7FWXe/IP6000yKu3d7nH7/a21593zE2X05K6HbDNu0Yowmp3vXY2qYj6CEmtMqMhEklT4YstemiJdmxjwO5aRYFIbww4/yALrZ33vN9J0zzrMaNbG2ubub3nqo7hA1ujSDdj7qO2oltprzpEAscIDNPAaR6sS/oxhQFxcBki7HISom2u9J26A0kAE45z9sEn6doDlIs8tF0FA5P/rmWsC3fHlYNkBNJdkzf+VxGZjoR2yDwQ18Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuMckVyWBIWOGbcZgPjb0mtp/XRUNcUDIozDLBUTdLw=;
 b=WWr+Wo2Vk6UssDzvyuNPi353QJ5YfI/2mHT6yPWhvk4C2w4fvGZJktMXvG9BBn4umrYbHyLQrXphoMwA3zMswaaUo4Rpn6Lz8iK6IMP6aKZtOAR4BY1dQHCZoipQ8pUmVX2VDeNl1fdkvbpXWprCoxCBNwZfcyX2RGT3oXoYabet4eiiiAk33p0spUqFFM3CmDkqNcNVAH3BnXWEsCOo10QCo2YwRJtkiC53XO2I3XG8voxVw8L0rTFChBxfgPGUZusC0KxH3LSRFmBx/n6tlQ62P/22L50mARe51gr5rdF4Q0PaoOVA36hTZmIt58JRqn8msm32wwNcV3+nIfvZ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: Query regarding SQUAD watch job submission
Thread-Topic: Query regarding SQUAD watch job submission
Thread-Index: AdqsGtXhN49/gNbeSoqkT+RmP+DvBg==
Date: Wed, 22 May 2024 08:08:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103E0981B612912E2324AA4C2EB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYWPR01MB8445:EE_
x-ms-office365-filtering-correlation-id: 533c7bbe-4fd3-47d1-b815-08dc7a364f4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?STBpbC9odnpRUWc1MzlhazhpVXFNanJEdm1Wdk84a3k4aVRsa05FTUZQ?=
 =?iso-2022-jp?B?RlVJSWJESzEwMit4NGltd0gzek9IeDkvYW1Gd2dOcWhGOWQrbGhINDJN?=
 =?iso-2022-jp?B?aXlJUklTVHdSbnVReFBYaVZ4QjFaR3QzaTB4aUR6cWVrWEcyVXVFUDJh?=
 =?iso-2022-jp?B?dktGWk15MVd2VkJPeit1NHY2eS9IZWRLYTNsZHRIQmVZZ0NxZzRJTnB0?=
 =?iso-2022-jp?B?dU0wS0p3WFRndU50R3ArR0lFSEdDQzhQQnlMWXo4SndaMDkxZytFSFUw?=
 =?iso-2022-jp?B?VE9LdFYvQVczWW1mYU9aZWZCUUtMbU90VzFHNkp1SWNoMWNYWXBkaXRW?=
 =?iso-2022-jp?B?UHhwVVhGekV3aGF3OWFwRllBUUQyRjNBRDRWRERuaXl4cDY3MWt2UDBH?=
 =?iso-2022-jp?B?eGZWWGYwOWNiREJYWFkyOTBJNm1GUC9lcG9LMXJFb1FnclVGSEpQZG9R?=
 =?iso-2022-jp?B?bU5ibTRtcm8xZ3BXUXNpUWVPT21oYVpGMDBDYmRRZDNmVHZXVUwzd1NS?=
 =?iso-2022-jp?B?b2FtQ0NTc2JTTDh1KzE0NWJ5YzcxRjlScGlCNFNQRG5XZkNNRFlQTXFx?=
 =?iso-2022-jp?B?VzFCVmtkeEs2N01ram8rK04vd3FubllVTVhZdHNLeGl2MFZhSnJnSWNF?=
 =?iso-2022-jp?B?R1NIMUp3a2VWL2JRY2p2cFUwVWVKNGFxalo2Yk1wcGI1TkxjODlUdGV2?=
 =?iso-2022-jp?B?amFabERqL0tENTQrUlhwQ2NhdklHY2hmTlY0WlVpa3I1Ny9rLzQzUW8v?=
 =?iso-2022-jp?B?YVUxaEZjQnJsenFvMU5SUXhUWjBNV0pvajVpMC9RWm9HMHBNZUxJM0t3?=
 =?iso-2022-jp?B?MzNzU2FILy9QOENnTkZoeUkvcnBFUi9NdEpyN3FsZSsyL0tHZllsTVBv?=
 =?iso-2022-jp?B?RzlaVDdFZVljQUkyNTV2VDRKYWxaUlRraW0vamh4anZINkkwUndEakEy?=
 =?iso-2022-jp?B?RThMcTRGOHYrdEErL3gwRk53V3VBa01iZ3E3NEVLV3pMczNSSmxhMVZ2?=
 =?iso-2022-jp?B?SVhpOWFDaWRlY2ZMdHErOXVqeXhodHRrcmVTU3hRTkRlbGhpOVkyQVhH?=
 =?iso-2022-jp?B?SkxDdUwxZ1h1a3B4UlFtYldjc0ZKNDZydG5nbUcvaDdjMFdDMzMvTnRT?=
 =?iso-2022-jp?B?NVFwTWJ6VkJ6aHpqQ1Iza0YzNmtDY283amtESXZ3QW44ZmtNZjJRRk52?=
 =?iso-2022-jp?B?eGtLcWRjUVk2VERmakI5cHBwL3MzTWtPNE5JMHR2Wm8wcnU0WlhKQzZj?=
 =?iso-2022-jp?B?cmdZRzNCT1NsN2JhZVFWQTl3ZWhTWmsrdEFua0N3ZnN5NGxtd20yTUJT?=
 =?iso-2022-jp?B?ZFhhOXdFK1lpL00rYXlpMkdqWEJFeklYS1JuWW5LL0FGS2pkU2lsRTJW?=
 =?iso-2022-jp?B?NkxOVGNwak92YmViQ0NvelltUElFL1RINWdWaitTNU9BempPZXEzV0Fi?=
 =?iso-2022-jp?B?dlBTdXAydkMxeFBvWnI5b2FxZjU1ZzJCaHhEUDV3cXR4cFhJY3lMbFAz?=
 =?iso-2022-jp?B?djJWSVB0dVVpV1BESHJiMVpibUFQdFVoVWMzeVFxNENOLzVoekhxcjNs?=
 =?iso-2022-jp?B?MTdVRjNYcDhtRTUvKytUbWFPaUs4L2VIbldGV29OVHZKUjNvK2NhUDZG?=
 =?iso-2022-jp?B?ZmoydFBSUEV3UlFLRDRRcE1YODg5WFBCTVZYUENvR2lvdTQ1WlZCN2Rl?=
 =?iso-2022-jp?B?VnBGanpjeVVNZXhzbnFYUUFlYXN6QmlNMXJCSFAxY3p6bm1JQi93dFhj?=
 =?iso-2022-jp?B?aXhLaW9HdTJyRjl5VWFMYXlmS1ZNN1Z2a0FjUm5GZHl0T3Q5UzNWeWJY?=
 =?iso-2022-jp?B?YkVTby9ERFowb1lHQ09JWmFxUER6ODgxSjB4ZVB1MmMvb1N0c25vbjlo?=
 =?iso-2022-jp?B?aFRzcEgxc2YybFdWRHVlZjI3bEpZPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TmhvZTBhZEdtRjdYSyt3eGpnWGFpYmN1TkpBaTJaWTk3bkFtc0RNMmZN?=
 =?iso-2022-jp?B?bjZtcXZxR3hNTk9KZG5DbzF4MDY0bjFSUHlaUDY5SHNXb1M5T29Sd05h?=
 =?iso-2022-jp?B?cmdVLzlXaXJBa2lhUzhXOHU0K1BmbGhhZGx6TzJNbnNVbndpM0JSbTls?=
 =?iso-2022-jp?B?dC9IT01hV25mTGZXdlE2QVBGUVlUOTVOVFhDcW9UQWxuYnYzK3FWZ2Rq?=
 =?iso-2022-jp?B?eVFja1hpcHoxSUZ6aWFkRFpaTG9MdGRXaHBRMTltQ25hS1ZJeGZBbWJi?=
 =?iso-2022-jp?B?cWIwUjlnUUplZUxoZlRzODNPS3FwaGt6YWJXTkdjakdVMksyVjJ2aS9J?=
 =?iso-2022-jp?B?VUY0L01Ta0JMNzdaeFRKWmxvMkRrVERJU3RoVW1EVThFR0JEd1dsbHdv?=
 =?iso-2022-jp?B?cVBZKy8vWHgyV29RMUVjYkhGclRrUmN6ZHlPeUFrVzZPckhxREM3cUh1?=
 =?iso-2022-jp?B?RE9ScjBKWXplcmsySFFJb3JZUUxVdXhUSGxiKytiZ2FhNHVSZU1pckxl?=
 =?iso-2022-jp?B?RjVVc1gwOXVBNzNiNzFNM2dYOGF3akZsTE1LRjRXNGNlOUhRUjNPZzZU?=
 =?iso-2022-jp?B?RTJCVVJwVG5raHFUVGt3NGFkVHp6ZmZZQ09ZaFlLeU8yTnlLUllHTHl1?=
 =?iso-2022-jp?B?U1hnY2pWUndtWTZzM2kwYXZlWHcwQkIxL2MyUkxUYndnbURBekJKVVM3?=
 =?iso-2022-jp?B?Y0RQWXd6MTFLQXNxSjBmeG5zbDVoKzI4aHlsakU2cDJtRXAvNkc4SytI?=
 =?iso-2022-jp?B?c3BDdm9jNTVLdmw5RXZ4RmRPWTZUK2NLMVc4dXNDaVdyOXZWVU9rWk5V?=
 =?iso-2022-jp?B?bUE5aVZFMU5zazE4cDNwWnQ2VWluNmdteEhvc2ZiTnFEb0pYLzZidS9y?=
 =?iso-2022-jp?B?UmI3ekg3WHJTQ1Y4OXFKVkVLc0I3RHErT1ByWUdNbFZ4aHUxV0Irc1Z0?=
 =?iso-2022-jp?B?b2l1ZjBPOFc3Z2QwbmxMaE03RlRaczV4OXRHSmJnZGVYWE50MTVBaW53?=
 =?iso-2022-jp?B?cCtEZE9KVkw4OThhdWJXTllxb1RXbnMzSGIvR3hFdklNVVJrd3JQcG0z?=
 =?iso-2022-jp?B?RE5DdkIyWFFhZk9pM3ZadWZPNHBFQzUxcjkzQittRHpJUG1ndmticjRp?=
 =?iso-2022-jp?B?aUlqc1QyY3oyS3RiSjVPNjRXd1NjSktXbnJabXF6VWgrR3NKWGtrbXBT?=
 =?iso-2022-jp?B?b2J5UWh2a0hxZVVyajVMeHFiSWE4QjJZcmExL3FSUWkvWEJYYU1nWmJF?=
 =?iso-2022-jp?B?RkNTUUI2SDRjY0YyMmpQbno2d0JXSnpHZituck90VjJDYVJwbE01SFhF?=
 =?iso-2022-jp?B?Q3QvMDF6NHVERXpxdjN3L0J5YnZHMzJPVDE4a0E0ZjRtMEtUVDVYQ1pn?=
 =?iso-2022-jp?B?Y1AxajE1ZjR2cU5Vbk9IRWtxdFdnWTNkLzdGYWpsMjF3SGZ2Q2xtaUo2?=
 =?iso-2022-jp?B?cnBkWlUwc3dMUWxHbmUzUEUwQ1lUWlUrRmpJTzdjdnBYVFl3cG1tSGFX?=
 =?iso-2022-jp?B?QUoyNFRsNXloaVRkME5aQ01lNEtENStQV3BzUUVqUSticFgvM29EeWtB?=
 =?iso-2022-jp?B?MnBBdkdjaWFEREc2a3VJL1V0Mzh1WXF5ZWk1T01mY3g1TmhPUC9vWXFC?=
 =?iso-2022-jp?B?dkNiU3NTR21VRDYxK01kWHlRL2RueERsa0ZBSVM1U1g5SEpmTERGd3Fh?=
 =?iso-2022-jp?B?amRrWXdVT2xDRldOTWJ3Y1NmeCtFN0hlQTBmWTk5WndDc2IzdmMveWNp?=
 =?iso-2022-jp?B?Yzd2akppOGxsT1ZNMFZHTXIzV3c3ZU1TbVRrQ2UrV1N3ckUrY09EbGVr?=
 =?iso-2022-jp?B?dzU4dzkzWEZJUWM0YVE4TTBzUlV6bjNBekRlVXpiWVU2WTN5c1AraGRp?=
 =?iso-2022-jp?B?MHc0TXlrSlZGcm9ITDVtbGh5ZnQ2U0l2aEg2elpEU1kzSmkyYTg0aFZL?=
 =?iso-2022-jp?B?ZGNCNWpUVjR5TU1aK3hpOVJEaWQyVFBlTFliRnpTWnhxN20yTlNvMWdp?=
 =?iso-2022-jp?B?Y1d5bURFdDk4U2ltYUlBOW9ub3g0MGQ5ZXVFL0h5VllubzkwZytuZkdI?=
 =?iso-2022-jp?B?OFlyUElhWnd4SDA1dEs1TmZIYlR0QmZOK05wZnFOL05GMTFWSkpiemNp?=
 =?iso-2022-jp?B?TlljSXp1WmxiTjZEM201bW85NFVtSGljY1VkZmFMTHc3ZVZtc21JQ2Nq?=
 =?iso-2022-jp?B?WTlTOEVlQWZscFhDWGhTNEloR3Voc0JIb0FVSzcyMGNYRG9FeWhGOFRK?=
 =?iso-2022-jp?B?NUhHZnc4ZVZ6bVc3TmxoYzdGdkZIeEx2NVhETStRSzZyQ2ZCbmV3QXlV?=
 =?iso-2022-jp?B?ZHdld2hla2xqK2l5Yi9KZFJnclFsN0RWa2c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103E0981B612912E2324AA4C2EB2OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533c7bbe-4fd3-47d1-b815-08dc7a364f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 08:08:05.7161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6hd/Cr4XAcO/RPBsEbatKcurbs5Y7C9+0yKFDVPYigJTWaPavZMouRCaR5mO9hnxkKo8Qnib3DfLtkMJrGYag5dGlfS4vzp6o4Ine0AnNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8445
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 May 2024 08:08:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15923

--_000_OS3PR01MB6103E0981B612912E2324AA4C2EB2OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

I made changes in this script to attach a watch job to LAVA job https://git=
lab.com/cip-playground/cip-core-ci/-/blob/toshiba/squad_changes/lava.sh?ref=
_type=3Dheads#L135. When I trigger this from isar-cip-core, after the LAVA =
job is submitted successfully, I am facing this issue while submitting the =
watch job -> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/6=
909129906#L161

I am using the right SQUAD token (sorry I initialized it in the script), bu=
t still, I am facing this =1B$B!H=1B(B{"detail": "User needs permission to =
submit test jobs."}=1B$B!I=1B(B issue.

Do you have any idea on how to fix this issue ?

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

--_000_OS3PR01MB6103E0981B612912E2324AA4C2EB2OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I made changes in this script to attach a watch job =
to LAVA job
<a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/blob/toshiba/squ=
ad_changes/lava.sh?ref_type=3Dheads#L135">
https://gitlab.com/cip-playground/cip-core-ci/-/blob/toshiba/squad_changes/=
lava.sh?ref_type=3Dheads#L135</a>. When I trigger this from isar-cip-core, =
after the LAVA job is submitted successfully, I am facing this issue while =
submitting the watch job -&gt;
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/690=
9129906#L161">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/6909129906#L16=
1</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am using the right SQUAD token (sorry I initialize=
d it in the script), but still, I am facing this =1B$B!H=1B(B{&quot;detail&=
quot;: &quot;User needs permission to submit test jobs.&quot;}=1B$B!I=1B(B =
issue.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Do you have any idea on how to fix this issue ?<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB6103E0981B612912E2324AA4C2EB2OS3PR01MB6103jpnp_--


