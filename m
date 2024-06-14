Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58125C27C6E
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 03:48:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.3390.1718336934322189262
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 20:48:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 45E3mpV21417272; Fri, 14 Jun 2024 12:48:52 +0900
X-Iguazu-Qid: 2yAbXhlxP3Pz1n49Q4
X-Iguazu-QSIG: v=2; s=0; t=1718336931; q=2yAbXhlxP3Pz1n49Q4; m=CMtnQI2Y4Sxfhqbc2qyU1+/9ewF0N7wAhQQLTeTKLeQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 45E3mo9H1853989
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 12:48:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAMDGg7jkHkzs06tzqOeDJVBGs1l0Q0SvM+SvvkZWQbDtzACjFGMxi12zF93cFm6b/9hGA2Pca1ghvH4Y2g3u9EE6qfIDX+aci5oVq18mcskZLgkWHXiVce/yZEO1UNUwWMPa0HPJv+N0xMFiJU/s+feW0Y4aoRL70eL9j9Yw8jWEPS7PfjMurJsk7q2mVI6wFTbxV0nceGj1nzxauH09vv23U1KbjvAcgQ6h46P80Orl1Lz6FpemkDB/TGW2FLc1cxH7mpSoL7XkaRp+NpVr043Rdj92N3L56QcNY+eFPaLktnraauUibV8UA98lEArLoCTvzWqyyPuKCz9z6yXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMc9XkWerJ0nvkf2iwAo6HfN8N2th28Oytqxd/StRn0=;
 b=jhaWHQP2FgnGmHiTLZNBlnv9XPrSyC27U5NQwzbJk1mHLJONyUa9WjnAGCAvWNfZV3TaFJ0zHzE7mymm8My0Fy8M9KM9Y83GmhrYp+W4Kfwus+Yc09bOwH7QkWcviiYA6kbYm3C8aWgdVSnrgdN7JELDXc53JpikoRROEWsCTeUtdjw8toUXJibZQ/OhAIW8ZVY95Eou43nRpPTKdTPHVM7kNrDhCvs4TzpdI0hXYnpJvss3YzJi4K2X5JHKU5inaQaBst9MGEsBxLyJEObGSBoRdFtxOtEJ9TfgEz6xNUcQQGk4Rbw3UpbWCxiZ8208FaCBpp3jYH40gBBCdshxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: Artifact download failed due to timeout in 'lab-cip-cybertrust`
Thread-Topic: Artifact download failed due to timeout in 'lab-cip-cybertrust`
Thread-Index: Adq+DRGNdZZqn7OhQqy7wVWWG8yu3A==
Date: Fri, 14 Jun 2024 03:48:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61030B7550E645EED661DCEFC2C22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TY3PR01MB11177:EE_
x-ms-office365-filtering-correlation-id: 173ffd57-05dd-4478-a135-08dc8c24e622
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VjVRdUY3YWFWMnV5eHpxZ003NEFaais4QVBEZ3ZrS1ZwNys1WHY5TDRP?=
 =?iso-2022-jp?B?MmRqMkN3cjU0SkFRU0RFMkIxTVc3endnMDhPK2JGVWJ4SWVjYU1vWEdD?=
 =?iso-2022-jp?B?ejBxQWgxMzI4Q053YWxIc0RRbk1lVUZMZW1sRkxxMTNzc0ZnZjA3Tm9K?=
 =?iso-2022-jp?B?MENlSmdsdEo4SGsrK0VBWG5WczJSSlgzSk5MMjhSZ3VtMDVVRTRlWjVU?=
 =?iso-2022-jp?B?UHZ5ajZjWlFzVGc5c1N2WnhnNS9HaE44R1N4REs4TkMwOE9nU0l3RmlO?=
 =?iso-2022-jp?B?ZXpNTGlCV0VKTlBRaExpd3NtUFZUMmN3cSs3WE1JcUwweE16dmdUMURm?=
 =?iso-2022-jp?B?WTgyd2tEeTE0YkJ6ck93NXBNdy9WRW51UVBmVUFLc2RoeGZERnlyYitS?=
 =?iso-2022-jp?B?NmkzK3IyZ1VDdzE4SHJ5Und6cVlySTh2QnFiTGdsR3dBK2ZEOG50Zklh?=
 =?iso-2022-jp?B?YytWZVhpVUUxaVhoUVN0UXZYREorSDZNRUo2dFNHSEJ1Y2NqOERHNzZS?=
 =?iso-2022-jp?B?d0JMT25PSWRiSmVoVC9jUzdJVnpiZTFzRWs3SkZGV25UZXp0Nm1tbjNY?=
 =?iso-2022-jp?B?cjJsMlZFbzBQTWZVVW96MzYzVk8rdDg2bVlNekFQdTluU25EUmlMUGg3?=
 =?iso-2022-jp?B?VzUrZFZac0tZRW5LZmlEUE1qRERBOFh2aW5GYkJ6akN1V0kxY0YwUVk3?=
 =?iso-2022-jp?B?TUlNWFFRTk4xRjdOTUJFUTFKaHhQTHpLejNBKytHT2Y1SXpid0lxbFNL?=
 =?iso-2022-jp?B?eGhEUnliVU5GYWk5Sld2N3JvTVhUTGplTFl3S01ZSEZUN2dKSlpyc1Zi?=
 =?iso-2022-jp?B?SEh0RzNsZjVqYTJITEN3L3dsNU9Gb0pGbkxuMmNweS9kTGozMnd3VXdW?=
 =?iso-2022-jp?B?UUFudTg3ZEFhOTFkS21hcWFYczVjVm5vRGI2c1BRa2l4NVlKcXhZNUxo?=
 =?iso-2022-jp?B?OUFPbzh0VmpRVXJPaTNBQUtPM1dpbEY5Z1VxeU9RaFl6cksxdEI1Zm96?=
 =?iso-2022-jp?B?YXBmOEVTbVI1MmVpUkZDR1FlVnFNZ2g4N3Z1OVMxbm12cjFlWncwclMr?=
 =?iso-2022-jp?B?SEFocEZ5YzdYTG0yTzcxckdobFI3RHZqbEt4RW5HYWV6OXJSdDVzVkcr?=
 =?iso-2022-jp?B?bi9mTUliSXBLdjZ3Y0pkU2MxU0o0OXRYM0tqUjZqWmlYRXhUc2JHU2xJ?=
 =?iso-2022-jp?B?RGtaRG9XU0drUEtXTTFwaVd2UnoxQWhaOG1vWXVML2h3RUtZNkRQaEpF?=
 =?iso-2022-jp?B?ZllpcW1rM3cvS09xeldOYVZoK0FOaUxZc2tpWENPS3p6YThsZEt0dmtO?=
 =?iso-2022-jp?B?b1BhbXdDMWcwV29JMjdYcWJaZk5NVkhUSndPOTdydk1CU1g0SXZpaGh6?=
 =?iso-2022-jp?B?eEMrQXJzZ1pobkU5QXVFR2plOHZYZ2M4S3ZWelZTNzJoYWRUaDNTTnRo?=
 =?iso-2022-jp?B?QmZ4blMrSzN5ckx0YUhpMzJINkt1d25oUUdDQXdEdFpVSmREa3YwdE5l?=
 =?iso-2022-jp?B?MmdBdkNwTDgwSmJTaWlneXNiOGpSQzUyeFhPeVR2dXg2c3hJa3BCd2xX?=
 =?iso-2022-jp?B?ZUVLcmhKYmswTENoMmM3d0VxSmg3R0wrOWNyTFd1VndqOXdkbVpMV0JX?=
 =?iso-2022-jp?B?dlNjMCtmMDV4QzM1TDdLbFZRRU1YWmp3WHZDU28yWGdjQ2NKWmpiRW1N?=
 =?iso-2022-jp?B?WTVsWUFqVUdQSW9zdGlUWmpQVmJzQ0JYM3RqcllndFFGcG81MHlsbkxn?=
 =?iso-2022-jp?B?QWxDVCtQNXQvVWhLb2xId2VwdnJaRkZIdUR6d3ZyNzN3RzlNTTlaTC9K?=
 =?iso-2022-jp?B?SVA5RTg5Z05RR2JFOTJUV0g0TVZDclN2SldlaitsMng0QWFzamZ0SDVH?=
 =?iso-2022-jp?B?Qy9hUlI1K2sxR0txTTM4aVlGaUMvZkZFMHdKUUI0K1pMRzl5Ky91L3hl?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bUZFS3JONFNiM2JVOG85amM3NlE0cW5XTjlYbjRhTW9WOVM4aU9RWUo3?=
 =?iso-2022-jp?B?VGk3aGgyaFdKbW8wQXUzRVBwM0xORTNCZ0t4dFlUWWI4SFBHeVlha3RS?=
 =?iso-2022-jp?B?bWNZemMzTzVMbEJEaXdoSkpUOEdPSnRWSnpPSnYyY0UxSUplSGJObHlQ?=
 =?iso-2022-jp?B?ZnNjRFU2R1JzdW0xWlFtMEM0OXRJRURhVUd3a2dSYTFhQ2Q1bnZ1K1pu?=
 =?iso-2022-jp?B?TllmT1JMUGdqYzM0NUoxV0k0R3QraDh6N1dqeVZsSlJhVGZQamFoT1Nn?=
 =?iso-2022-jp?B?Rkd6dlp3Q0NKQW0wTnF4eEVRcjdLajFMZzlraEI1K1YvMG1SL2Uzd2pv?=
 =?iso-2022-jp?B?UTJuUGdJWktoOU5ZRnlBNUxsMWFMcW15UkQ5Q0dJeXA2c2s4VWwzMjc2?=
 =?iso-2022-jp?B?c3Ivd21JWHMyVldRdm1FS2pudHZCS09SNXM3Zk9TU2FrdFRrZlpVa3Zq?=
 =?iso-2022-jp?B?a0VUb0RpOGk2bmNtZ3FaUUhCRnVVQ1NhcUE1WjRSQTRFdGdzMmsrRjlq?=
 =?iso-2022-jp?B?dWRPRElXYVV5bHF5elpWM2pGSXZyUGZtd1l3emUwT29FZ3V3UkpYaEh4?=
 =?iso-2022-jp?B?aStJTFcyWWgvazNKQU44RSsreVlydmhYR3F1blZ5ZHRDb2JVSG5qNzIw?=
 =?iso-2022-jp?B?QzdtQmwxK1VRMU1ma2Rhd0dONkdkTEVuWlRxMktYdTZ5OXp3cG9Jdmp3?=
 =?iso-2022-jp?B?dVRHOWd6NkVvSGpFRXh3K21BR1hiUHZUY1VKV1hxS0xqQ2cvbERaT3pW?=
 =?iso-2022-jp?B?bGc2eWVvWTh5WW1ob295ZXpvMnB4M0lpNDVBaTdLOXRtdUdscmplcVNG?=
 =?iso-2022-jp?B?UXVsVzRXZ09pZ1lNdG80NFNMdnN3L1puL0JXVXU3Nzh0TUpRdC9pbllQ?=
 =?iso-2022-jp?B?RWtHdExkVm9QNy9SRXk2L1pEMWd3TmtmcDh1WElXVzVNZDA0QU9RZ2Zm?=
 =?iso-2022-jp?B?RSt2RHdsYnJrNTBwSW8yQjNJbXVwaElUUnNEZy9LdVk0dVIzZGpoT0I3?=
 =?iso-2022-jp?B?Sk9rUVFxd2Uya05GL3VpNytxeXVLRXZEVFdlSWFsVnJ0U29xbGtId0kv?=
 =?iso-2022-jp?B?NUIzd3V5ZW1tSk5qbloyVHRhQWNOQTZJNGpsOWVnRlBkdjg3T3hWUXN3?=
 =?iso-2022-jp?B?NFlVSzVoSFdnQ1NOa1Q3MWJ0Y2NuQVVwUS80eHZGT3c4cWR5NGxQTnVL?=
 =?iso-2022-jp?B?ZTYrOE5HS3lwYU1lRDJaaE9Zcm9kUUthc2RNb2x4VDlXRVlSTmdLTVpP?=
 =?iso-2022-jp?B?ZERIb01HNzkxdEI1RzdJU1dyL1RJUEt6N1dEU2hia2ErejVHbDlabVZr?=
 =?iso-2022-jp?B?c0JjRW9jWEZwVnZWTGk4Z09mOUpXUlowODB2TTBCRWVneHVlL1oxWjNw?=
 =?iso-2022-jp?B?dFFmTjgwb2JTZlZTbVVYREVBUlp3c3BIZTU4NGhvOC9FemQ4c0V6akpM?=
 =?iso-2022-jp?B?VTBIVmFKbjRuenhsT2pQT05jK2xKRVVidXQrUGYzYU8zNEFkem1wQlhu?=
 =?iso-2022-jp?B?K0F1V3ZqRE53SHhtR1N4U0dWWjF2Q3dYZE5wSHRvSUxtVEtObEFFQVBv?=
 =?iso-2022-jp?B?bjZRS0V2bks5dGVpdkdnb0wzWkJ4ckxEVXBoTGhmcDhDT2k2WitNcjhx?=
 =?iso-2022-jp?B?MVJsL3VnbkI4OS9TMGFPSm1LcHZKM1MzOXNUQ2FOVUprMlpIdEtFQTJG?=
 =?iso-2022-jp?B?c013Y1JDc3ZxcTNFZENMMUZFNVRqSmZMYkw0SlFhYnN3RUNpczR2YUtk?=
 =?iso-2022-jp?B?QXRGQWlYNnRrRXlKMWFGMFdtMGlKc0l2aUdtNE9xeDRVMmlxQmY2aFgr?=
 =?iso-2022-jp?B?eFhDRmhOTzZCR0c3bHhzYTVrLzh1ajZWQUFCSGZIN0dBOXFpMzdhUEtk?=
 =?iso-2022-jp?B?bnRaMmhEeDBOYVowYnloRUNJQlFOc3B6RzVueS9oczMvdFY2MHFWSDFw?=
 =?iso-2022-jp?B?Sjl3N3ZNVVVielBLOU4vb0dGVlZrZnpjWUhDSlpJamFtSVhDdlRXWGcv?=
 =?iso-2022-jp?B?aW96Mm1VSFNEcmhyMFdEcWRUTTVHQmVyZUErMkpXL0hwR3FFTkxNTGFW?=
 =?iso-2022-jp?B?emZHdHAwYlZidmtHei8vMDNXSUp3eENwQ3hxMjgxQWF6cURyMUFoU1Ar?=
 =?iso-2022-jp?B?YzQ4Nys3QjlPQk0xUUlpR2h5d2VCbnBKK3NveUpCT2gyYVFXeDFFQVJp?=
 =?iso-2022-jp?B?VXFlNHhRMmhremt6eDZKeXdvQnNzRW9pcnJQNHlYNVpyMjdNdE4wOXVj?=
 =?iso-2022-jp?B?UHozTHhCUzBrMnlBVlIrdHVwWUtjQ2V0TlZUMlpRLzRTRnNrbVhvcGxF?=
 =?iso-2022-jp?B?eU94WHhlVmVja25aOW1wOWZFRWRPRnhaVXc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61030B7550E645EED661DCEFC2C22OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173ffd57-05dd-4478-a135-08dc8c24e622
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 03:48:48.7339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/xkTS0CU6mtZHdVBipXR1VtwMa3/sv+6l4AYHz0axmbvu64u5cOVQG/YqL9unFfWXhPtxq8xb/WbnwS6HYGqJx1/k+R7NDUjQ5Wqk5Ijk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11177
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 03:48:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16224

--_000_OS3PR01MB61030B7550E645EED661DCEFC2C22OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Hope you are doing well.

Yesterday I noticed that jobs which run on =1B$B!F=1B(Bqemu-03` device in `=
lab-cip-cybertrust` are failing due to a common issue i.e timeout during do=
wnloading the .wic artifact.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7094898973#L69=
9
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7094898970#L98=
5
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7094898965#L67=
0

Do you have any idea about this Infrastructure error ?

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

--_000_OS3PR01MB61030B7550E645EED661DCEFC2C22OS3PR01MB6103jpnp_
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
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yesterday I noticed that jobs which run on =1B$B!F=
=1B(Bqemu-03` device in `lab-cip-cybertrust` are failing due to a common is=
sue i.e timeout during downloading the .wic artifact.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://gitlab.com/cip-project/cip-core/i=
sar-cip-core/-/jobs/7094898973#L699">https://gitlab.com/cip-project/cip-cor=
e/isar-cip-core/-/jobs/7094898973#L699</a><o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://gitlab.com/cip-project/cip-core/i=
sar-cip-core/-/jobs/7094898970#L985">https://gitlab.com/cip-project/cip-cor=
e/isar-cip-core/-/jobs/7094898970#L985</a><o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://gitlab.com/cip-project/cip-core/i=
sar-cip-core/-/jobs/7094898965#L670">https://gitlab.com/cip-project/cip-cor=
e/isar-cip-core/-/jobs/7094898965#L670</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Do you have any idea about this Infrastructure error=
 ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB61030B7550E645EED661DCEFC2C22OS3PR01MB6103jpnp_--


