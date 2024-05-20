Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5816FC25B78
	for <webhook@archiver.kernel.org>; Mon, 20 May 2024 11:03:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.57430.1716202989458280907
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 May 2024 04:03:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 44KB37AE2053044; Mon, 20 May 2024 20:03:07 +0900
X-Iguazu-Qid: 2yAb3nxBqWoQbRoTMw
X-Iguazu-QSIG: v=2; s=0; t=1716202986; q=2yAb3nxBqWoQbRoTMw; m=wJ6EPOtsi+7Kpl4qfmMIgR/66yq2nZPGNCcHNNBaSsQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 44KB35FU014958
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 20:03:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFUdmWE8VyEsIFtf+I6/KdFhcWClMOMOBLVtjwjm3q7yV2Kl5rtoZ/8diY5KRjHhvj5EHJemBB4HUfBfKYvGdQB8Ls/PowsL9YuImqSI8ixgmvsyFDs8CI9kMHGORrVSDgUSFbcf56OQ5dHV1+qsAsMLJhOPboB1Y2Jpw4OHIxKIfGp03Y5aBlAe3p4CfMhAlKGZty6UUCryfH/Hrh0gbx9+2/KmOfW2WKZvccZwhA2jn5hctBpdhgQRwE5gStPqEVCx26Ub6P0aqrbFa5U3/nE9+4IL0Kmfp3mG9JQz/OsRNGcHfxLA5MAkbRSEvOySFmvLcH5AvewURpbHsRzpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9RZy4GuC4fhESIWmZp9TByD3lafHQVyXMWHZydDgaw=;
 b=mfdA+h17gWO+oJPeI8+eJsmNcLA8icgAoq+uVtzWFjunhmmkfX4sQh4vGbU9CdkZwf8sOBuQaqiPHMvL7x3PHQhHQdZjZs/Woy2RfiyO28RV4CKQewOjgvVWh3UeikYIreVaZJMNHOWv9cTxobfQeA26HZhAIHh5QRXCH6XTBIOZ2zhaTDbxs4v9tElFqQgn/2nKq/0MNiKEtZZ5rhcLnKuQE4VbZ3SoqNlxBhUsN1/hVvKER2XeFMDrRTsl6JGeOk6XB2mEWzbwBZvq0cYr8LnCOcVQKzxGE4RvbXGfa63J2bjU+J5WXIp+48IR6i6k/HzYmxt9yVHWKjM+oX06UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: Request for details of groups and projects for CIP Core in SQUAD
Thread-Topic: Request for details of groups and projects for CIP Core in SQUAD
Thread-Index: Adqqo5Lcfsizrm+uRC+ud40FclQzaA==
Date: Mon, 20 May 2024 11:03:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103A2C4F1E3809CF3463F15C2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS7PR01MB11821:EE_
x-ms-office365-filtering-correlation-id: 6ecf60e6-aeb1-432e-0d5e-08dc78bc6b7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?N1VxUFlSMFBZZUZacU5uOEtZUGFReDdTNWF5b2ltY1FDSFRJUTJHRzJI?=
 =?iso-2022-jp?B?Q0JBSmorV1VibnFLaWprVjJtNTNkMXRLWi8rc0hyUW1CU1F6U2txUlRk?=
 =?iso-2022-jp?B?V25vVlVrdFlKc05uVHZJRWpkdG9ucjB3MnJibkxqWUZuK3NQSXRCbGdm?=
 =?iso-2022-jp?B?emJKR2tidWFRL2pRanlGa1FmQUppclBlK1U3WGU3Z0R6RWpoMHJDeTdJ?=
 =?iso-2022-jp?B?RVVhc1BiM3hhQzFCQ2VEcDRzaHlSNklTQnVUVzhGRG5ob1lhZ2RTY2h4?=
 =?iso-2022-jp?B?R1hZNGFpc3ZpS3ZaaGQzOU51MTdmRnNUSnlob2lBK01nSjFzc1ZxTTZa?=
 =?iso-2022-jp?B?cTRkUU5SQWtERExNR0VtMTA4b0NXMm80VmQ3dGdGeHpoTzQ3S2t5SXRx?=
 =?iso-2022-jp?B?eU5JZWMweVNBWTEwOVlBbUhWNmtjUlN1UU9EejRrdnlFYU5xWFJyTERi?=
 =?iso-2022-jp?B?akplUUtMUnFtZEp5dVRydHlyNE1kbU5MaFdzZ1o5Zk52Wnl6YWx1dlcx?=
 =?iso-2022-jp?B?dURIM2F2SHpGQ3V3UmY4aXJWSklxaVRkU1NxRHhBMUtUS1oxSTZKTzI4?=
 =?iso-2022-jp?B?bzJkK1E3RENkdm5xaHV5ZmNpV3ZZVXIvMXhJUktSVHg2c2kyS3ZCOU1q?=
 =?iso-2022-jp?B?WHBIdEwydWlTWjR2T3BXK0hUeUhQcXA4SFNjV2ZJVTZhbGVBNE5yNlhO?=
 =?iso-2022-jp?B?RmRHSXFsUld6T3ZkdEF3dWNzLytJZHFTdmtqeDlsa2p6Yk9FL0plMTJs?=
 =?iso-2022-jp?B?bmY0UUxSUVNvdmlQN0F3ZC9VUmZQTi9mZmlMd1FHeGhiclNwWHk0c2Ir?=
 =?iso-2022-jp?B?RWNGVWpQVDQwOE5sNXE2NTdSVStKcSt4c0w5Tk1iY2Q2bHl6V2p5UkFj?=
 =?iso-2022-jp?B?NjVuRjM2ZXI5ajduYjBjSTgxdjBKZ2FsTXptMkliT2RqaWxDMHF6dm5w?=
 =?iso-2022-jp?B?SjYvaThxNHNyTjZWOGJaTzFsN2dTdlh1MjBHMGd2Z2J2WGp5UndGVFhO?=
 =?iso-2022-jp?B?S3JQZnNHQVkweUQ0aVFwUU51WVZGNTJXM2NEd2Qra05YQ3l0R2g5R01J?=
 =?iso-2022-jp?B?V0tVVG80bTVVRVdjZVZvQzFiSFNWdDJ1dXJFenJWWXA2YzdXdTUyWUJ6?=
 =?iso-2022-jp?B?RUdCeU9qUFF6QmtVSzliNFNyUnY4RW5seXlIQTJOZ0o2a0Z5b2N5cUp4?=
 =?iso-2022-jp?B?MS9nSkVhZEs0YjQ0TEFPNXRLZG00Q0JRUkVWc1FubnE3aEtkazFLSVNH?=
 =?iso-2022-jp?B?Q3RUN3I5c0h3TVgrQXFjZ0pEM0RpUUN2STA1bjVtTzBwRjc3RXlNOWxw?=
 =?iso-2022-jp?B?TTVTOGNjdy9CaFB1V0kzMVhkR2s0TmQ5b0tHUUhsYk1lR3d1YWhra25y?=
 =?iso-2022-jp?B?WUdPeWVyaFJCZmdiRjFFVWZxK0R1UEpMNGg0b3lBVDJjbzhuM3hjbkE4?=
 =?iso-2022-jp?B?VVhaa3ZMU29zU05lS01XYnRUQzFRYmhzRUNvTmFSdFdhMk5xTXF6WXU4?=
 =?iso-2022-jp?B?SWtnUitRZ25kMW9lK0VtWWc4VWgxOHBIYTk1WW1EODlFWktLUnczTGs5?=
 =?iso-2022-jp?B?L0orK3E3QnBJWDAwTFZGOG42Rm9IL0JTZ0pFclJYdXhmVXhIRzkvUkZj?=
 =?iso-2022-jp?B?NTh6enRBcVNNNTV0L2ZyYlorWmpsekMyakV5L3RnMnkvZEMzdEIxdUtW?=
 =?iso-2022-jp?B?Zkp5U1BrRXd1ODg4NTJyK0JoR3dmVUpwNGpEaHpmdHdHaVNyWmJic2tX?=
 =?iso-2022-jp?B?VFo2amR2d0lJOWw3REpOMnRHRklpZzgyUkxYUW1TdGZGOERrSnc2alpS?=
 =?iso-2022-jp?B?WXZvSVJZbE9uQkRXZzMyV0VSTk9Ha3lPZUptMk81K1hxa3ErWTd6VnVD?=
 =?iso-2022-jp?B?RUQ4cWJ1cnJWNm5KREtaa3piZmduOE95SVhOL21Wdzhxa0kyeS9ZNXA2?=
 =?iso-2022-jp?B?RG9DWTZFbFJHUjEyUDJQTWJmZjdrUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aVh1UGRwejRBTHd6NHk5N2I1ckM5NGpMY25SYTFMOEtBZkdkSDNQTzA2?=
 =?iso-2022-jp?B?WDA3bmhHVFYxMStZS1RvK3A5cCtOMzhUbi84OHhObUlTc215ZFZyWVlQ?=
 =?iso-2022-jp?B?SUlpT0tHVHA3VUlBS2xtNXQ1NGhQQWlnaTlET1NoR0d2OUhFWExTdHpz?=
 =?iso-2022-jp?B?Ykl4bk5HVHp2RzZ4ZWhxdDN0S3RSb2hVanhXMVRPa05NUDRMWXY0TUVo?=
 =?iso-2022-jp?B?eDBzclpzK1VwK1lPVkEzMlFpdzZYWVhmakRtWjFJbTl0V2VUMlJtVXo0?=
 =?iso-2022-jp?B?TUlzczI2T1pNSWhHNmJaaFhsdWRab1VyM1I0eUpvZG9mVG03dVBnUVgr?=
 =?iso-2022-jp?B?bnFZR3p3MkZQQWRMTERRUHVORUFQVlBOaThrSEVYcGowY0VpYzUvRm1s?=
 =?iso-2022-jp?B?c2NTdHUyVkEwaXdUOFEwUUNCeVY2b0NrZ0hvUGtxN092Znp2RE5ZWVVz?=
 =?iso-2022-jp?B?U1JSTmx0eER4a0ErREgyNGxYeVZJTE05THc4dGhPSFBrQXJzYkpvUDBL?=
 =?iso-2022-jp?B?MHg2dEk2YlBCeWk3Ly9FU3l2RTJFS0J0Yit2dDFicHFGOE9SaGk5aUNF?=
 =?iso-2022-jp?B?UXU4T3U1TnVpclBobDFhMDNLdzBHc0JGSHpaS3d3MURIN0pobjkvR2tS?=
 =?iso-2022-jp?B?RldodWlLZDJwdjVLRlFkcmtsWUhEQUdXT2wrK3BOdW5ZTENNdjlOWjFB?=
 =?iso-2022-jp?B?MStXS1ZaL28ydU15Zjl5VkRWa1gyVlhWeGR5TndsamNDVkJ4SWdCaHZC?=
 =?iso-2022-jp?B?WGNVdkRqSVd6QVBYTk5RbEhxQXpBOUZyRVZpODkrRjI2bWtkSFFNYnlT?=
 =?iso-2022-jp?B?WXJOM0dlRWltY3EzcUZoZFFDSjB5TnlncGthbnJ4RTkxQWpIbVRORWVC?=
 =?iso-2022-jp?B?cDBPNSt5Q0c3Uzdqb2gzb05EbWVmVXNrSXFSUnJ6ZXJnbUt4Nk1ITURy?=
 =?iso-2022-jp?B?ZEppNkMyZDExMi9zbTkzVXRKQjY5ZEY0Y00vSWtqdGtXcVdWV0xJalA2?=
 =?iso-2022-jp?B?SE52U2JuZTdudEd0cGROdy80dVpVaFloVlN5OEI5TXY5THhoOHUxcERx?=
 =?iso-2022-jp?B?UStyNUlsOVJ3R2pHaWJpVTdhYWh1cWlQVjRJSGh2Wm9PZEVtaEFKVWpJ?=
 =?iso-2022-jp?B?SlJaYW8vOEJOWFhWZncxSStOU3cyQjhpY1ZIWDFPNmpWd0U2VDE3cEZS?=
 =?iso-2022-jp?B?YkYyc21iaHpod2JMUFRkOFNKc2laL3VGNTVJTUl1SDVFQVFuTFdzR3BX?=
 =?iso-2022-jp?B?UnhrUDJWaTdhanZIdUNlK3NrbzNUR2QralREL2NXTEpUT3dSM0hyTW5s?=
 =?iso-2022-jp?B?OWRUQXI2OWJQK3VueG1SZmZrM2pCUkZ5aG9wbGc5MlNXd2N6UEM3QzFK?=
 =?iso-2022-jp?B?Sk53N1o4a0Y3UCtON2phSDdaV2k5YmNtenpndzI0Z1ZLZWlGTGw5MHVw?=
 =?iso-2022-jp?B?em1GbzVIK3pReU4vWDJyQkFQYVdPam1kb2U2NmYvWG5HL1dtbTFTWG5u?=
 =?iso-2022-jp?B?SGNmWW1DdVZhZSsrK3JpSWM0VFAwbjJXcEpIeEJGRzJ3azBYQzRGRXFs?=
 =?iso-2022-jp?B?UXBPNGY0am5QNzE4OHRFVlR2K1lIdDFraWFJR0lNa1czVWR4NXNGTnJy?=
 =?iso-2022-jp?B?SUF4Zy9xMys5K0piZDArODRPekRPZzYvb1BYRzVBU0EwMmIvaCtraUIy?=
 =?iso-2022-jp?B?Zk1PMEd4UXVlQ0ViYkthVnhOZHh6TGlNcndPNk9hUURxTEtpOUVyZS81?=
 =?iso-2022-jp?B?YWFxSzBLVUZhaUtKTm5odXIrNnVnSWprUXV4UTVZK3ZjbHYrQkF1dnVp?=
 =?iso-2022-jp?B?bnlOSWNIK293TWVrdVVnZ2JDUlp4aCtSRFo2RFB0NDVVb2NFTVpNSDZh?=
 =?iso-2022-jp?B?UEZRNHBzbk9FNzAzeUVEYk5CU0ZkM0dyS214Q3V2NExBL1E4NndPbFZ0?=
 =?iso-2022-jp?B?emgva2xEcVoxQTcrQmthNUc4VE9jYm1sWmJwTDVTSm5uK0ZrOHBIaEtP?=
 =?iso-2022-jp?B?VmRURlBKS0I3Y2RicU1iZ2lpSVhvVXhBRTNXRnJMbnVZWVcxcVgva0RV?=
 =?iso-2022-jp?B?TUdsamd0L0FaWVZTUWIrQzI4dExuQkFDdWI0ZTdXT05qVVJaSjhqa0x0?=
 =?iso-2022-jp?B?M2h1cXBGN0o5ODFZNnBueEM1eE9YN1QvQ1ljRHZnYjdNNFJEWXpLQi9N?=
 =?iso-2022-jp?B?TlN5Sm9uWTFYbDE3b2xkMHlFNElBcTJDellHVVBBRjQ5ZlVuTzlBMmVP?=
 =?iso-2022-jp?B?bkROWkpuSXk4VytBMlVoY0o1V3oza2VOMTNJNTVEc0NNaWZqR01wWFo4?=
 =?iso-2022-jp?B?ZHluVjNHMjA5cUsvaERsa2dGRDZpZDlUUmc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103A2C4F1E3809CF3463F15C2E92OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecf60e6-aeb1-432e-0d5e-08dc78bc6b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 11:03:03.2034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O1QS7oLtPf7Ir7l5KON07t5K8MwPlYxIbdITPMySkRNgEs32Xc8icpGNve/YbIEM+WFPLlZMx0bGIjlibF080hSZSMTgYjawjvH2zoWwgnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11821
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 May 2024 11:03:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15919

--_000_OS3PR01MB6103A2C4F1E3809CF3463F15C2E92OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

I am testing my SQUAD related changes to push CIP-Core LAVA testing results=
 to CIP SQUAD. I need the group and projects slug information for the below=
 items so that I can add those details during SQUAD watch job API call.

curl localhost:8000/api/watchjob/<group-slug>/<project-slug>/<build-version=
>/<env> \
     --header "Authorization: token $SQUAD_TOKEN" \
     --form "backend=3D<backend-name>" \
     --form testjob_id=3D$1" \
     --form metadata=3D'{"device": "'$DEVICE'", "CI pipeline": "'${CI_PIPEL=
INE_URL}'", "CI job": "'${CI_JOB_URL}'"}'

I believe this information will be available in CIP SQUAD administrator pan=
el. So please provide me the slug information for the below mentioned items=
.

Group : CIP Core
Projects: IEC Layer Testing, Secure Boot Testing, SW Update Testing

Thanks and Regards,
Sai Ashrith Sathujoda (T S I P)




--_000_OS3PR01MB6103A2C4F1E3809CF3463F15C2E92OS3PR01MB6103jpnp_
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
	{font-family:"Aptos Display";}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
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
<p class=3D"MsoNormal">Hello Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am testing my SQUAD related changes to push CIP-Co=
re LAVA testing results to CIP SQUAD. I need the group and projects slug in=
formation for the below items so that I can add those details during SQUAD =
watch job API call.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">curl localhost:8000/api/watchjob<b>/&lt;group-slug&gt;/&lt=
;project-slug&gt;</b>/&lt;build-version&gt;/&lt;env&gt; \<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; --header &quot;Authorization: tok=
en $SQUAD_TOKEN&quot; \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; --form &quot;backend=3D&lt;backen=
d-name&gt;&quot; \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; --form testjob_id=3D$1&quot; \<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; --form metadata=3D'{&quot;device&=
quot;: &quot;'$DEVICE'&quot;, &quot;CI pipeline&quot;: &quot;'${CI_PIPELINE=
_URL}'&quot;, &quot;CI job&quot;: &quot;'${CI_JOB_URL}'&quot;}'<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos Display&quot;=
,sans-serif">I believe this information will be available in CIP SQUAD admi=
nistrator panel. So please provide me the slug information for the below me=
ntioned items.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos Display&quot;=
,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Aptos Display&qu=
ot;,sans-serif">Group :
</span></b><span style=3D"font-family:&quot;Aptos Display&quot;,sans-serif"=
>CIP Core<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Aptos Display&qu=
ot;,sans-serif">Projects:
</span></b><span style=3D"font-family:&quot;Aptos Display&quot;,sans-serif"=
>IEC Layer Testing, Secure Boot Testing, SW Update Testing<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos Display&quot;=
,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos Display&quot;=
,sans-serif">Thanks and Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos Display&quot;=
,sans-serif">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Aptos Display&qu=
ot;,sans-serif"><o:p>&nbsp;</o:p></span></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_OS3PR01MB6103A2C4F1E3809CF3463F15C2E92OS3PR01MB6103jpnp_--


