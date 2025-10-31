Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B76CCF9F0
	for <webhook@archiver.kernel.org>; Fri, 31 Oct 2025 01:39:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.5358.1761874752913158418
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Oct 2025 18:39:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=eeyeKzG9;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1761874745;x=1763084345;bh=OB8yCIGca7uSA511sInl0bp1hVhSQ773RObyR
	5ybtaA=;b=eeyeKzG9pzQKi0MGpiwL8fGcQ4jMso6xF4r+wncGWVIMqcknaCXQBQwz9gM9T7FW/Yv
	XHuCc+prNIfRk3HDidvLrwuWSTFugvPi/C+raDEfiIwv1GCJTrRf9Pn1k1uMtP2/w7AQkyr8thPrE
	tTHuh6aVygzMEBEj281FDk2AHOMIv6ZLSGF4FhUjRHfJiowtjd54jflFkioJdCNSAFT8vCWoWdsc8
	yarzmOjJUyRVJNUCp2xoq1yzHUWrfmo2w3tFPZSOx+ET91qaGiBKGg4r0H8pGassrNgb017NmvfTa
	UQBPGgrIo7d/1FjEajLNYqrZ7JIDmM9pBD6l4BETZKNA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 59V1d4D51701764; Fri, 31 Oct 2025 10:39:04 +0900
X-Iguazu-Qid: 2yAbL6ern57RZhhcbz
X-Iguazu-QSIG: v=2; s=0; t=1761874744; q=2yAbL6ern57RZhhcbz; m=Jvcw9VRZNXC93k5+U8dCGXS5D+w8mCO9lTs/n/teodY=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cyNtc2dMgzyPc; Fri, 31 Oct 2025 10:39:04 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7X7aUIokXP0vZJGyB4ZlaQJAphy0hRKWrrqQomCWdCyTZ6OoMYsgg3/ntqBlIjsUu+7G0nbJvvFSy4zmM1HhYClPqnED+8ZRFvEXRnLXsZZJRZSG1bK1zJEXx8UguijEIqkHV8e/FzQWHSR3cErX6qgxw/z5JsSsEJCq9lXcy/784Ba2eFNVR+CkNRBBnQcMfSF+2wFzWUYuJCyUPXi1Fs2D6dddHdMBDcgTo8CtJUc16fFMQZI2O0wi9s9GRiL1TMKagLZDjeN7vzsbSgFIjNipkxkkhsQLZNbXXEVy9EDmY1kIAgj4iJdXghlLK+hxsMYBM2hmdf+0AmWWiL87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTsH2fLI7rGRKW9sWxIIlHj/guK+OfwBccBmGtPbhxU=;
 b=NaaxVn+aN006+XyFy6lKH6wQxfYN4Sed4XacPz1+JzfwNKlCGKcjJ0OjHfaMY/AMVy+SboYggM0KpgqYKcmn2h3s02bVtEzSt1OL5wt8I8equlAFmqgrVi1J4l0yvFm/5OuNmRoMnJ6psdRUndncBVup63oI1MHBYe1wUmvpffemoxVCK2GZ4JkvnmBlRIZO4JPpmUXw/4br/IwgUypZql+ymlnKk8dekC9L2hrJKHyTcE5RikTuAmqMQ7t5biAOHgwiYhXNM9iZuPd7+IaKGNZvyNWw659ouv3GRCOZPoOwSLtu1CJ5TU8yd/FVuXDjg7nD9UYSlK6JXT64GV5JHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
Thread-Topic: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
Thread-Index: AQHcSXohAN8na7gZ1UiuF/m8YRQGZbTbeyww
Date: Fri, 31 Oct 2025 01:39:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148188796779012A1BC1EDA69CDF8A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251030084927.47505-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251030084927.47505-1-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB10232:EE_
x-ms-office365-filtering-correlation-id: 50cdb4fe-c5e5-4d7c-bbf4-08de181e4524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|13003099007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cmdNTCtPVFlTVFgvSTBrYUYzUFR3NHZLYWM1cldpeVdPVXpESmhvWVhB?=
 =?iso-2022-jp?B?dHBFTHg5aE82YTlFdmErbFIwTVoxa3A4VnNsS3MzV2xZTlJvTEVKdGJm?=
 =?iso-2022-jp?B?Vi9udDBDWmdYWUU3RTJKTDR2d3p1M0s0OEZ6TCtNNXp1MlQrSkFUZmxo?=
 =?iso-2022-jp?B?R2NRSFJoQnQ4b1gvbGYyZEFzZGIyVmhjbnRJbkN5d1lrekl6bHY3b3Ni?=
 =?iso-2022-jp?B?RERaK0N2WWNkbVN6cHFnakVDc3VQUEhiY3ptM0U3Tm9zdDhhVW13RmFS?=
 =?iso-2022-jp?B?N0ZZRlFNWGFaZEFJS09pUDRTcU13YnMvTXlSRTI4ZWUvamp2K2hrOXZy?=
 =?iso-2022-jp?B?b0hsMWtKZDREZlpVcHg4bWd5MzBraTBzRDB1ajd4SHZ1OENxa1BrTHF1?=
 =?iso-2022-jp?B?WmludVd2RkZhQnZnSXl0T0F4RE1RcTZwRjlkeVhHN204RVZPK0JSdHJU?=
 =?iso-2022-jp?B?UWZKb203Q3ZpWXFCWGtnVS9HVjJHSDdHUDdsQmVKbDV2eUI3T2luTklV?=
 =?iso-2022-jp?B?ZUZCcWRlWUM2WGpRRnB2Y0QvOHJJcDRmWi9ORDJWSDkzVGt3bzlSTCtx?=
 =?iso-2022-jp?B?c3BzNzhVQ2dzYkJXOGIvL0RmejZxZGJVSTJBT21ISHJ5LzN6dGVCMmp2?=
 =?iso-2022-jp?B?dU1MVWYvVEIycnF6TGJNdDlGTU9SeERjWnFTSUZSbGlOeTJZdEo2SEto?=
 =?iso-2022-jp?B?THFkcFNPbnpQb2htcUNIYzhnTGwrYnBzRWZYODUyeHJIblU5emZZRzM4?=
 =?iso-2022-jp?B?K2dwdlhoL01SVDBGV1RQVmw4eHFMT1ZxSnZuUkYvcGdYNkw3WmJLTytr?=
 =?iso-2022-jp?B?Vi8rZWJDbm5kb0pvZWU3UzFrR01MYUpHYVI5dTNtbjhEMFI5SHBHRE9F?=
 =?iso-2022-jp?B?WVVYMSs0cFl4RnFmR3NBOE5MSEFYUVhrZWVoRUgydE5IdWZQSFBqT3Nh?=
 =?iso-2022-jp?B?YlNURTM1NWh5bHN4Y0krMUF5SFRoamxMcGprWUpCMEtWQmJVSHVNUXZa?=
 =?iso-2022-jp?B?SUhLeEgwanZFK1F1RTcvUmZ5WEM1K3lpVVpZSEZsNnRNN1JtUFpQSVk1?=
 =?iso-2022-jp?B?MmVVd2xEUWp3RU9SSHZraDFwQnAvSzFpTUg3MklpaWNXc2pkM0Vqbzgz?=
 =?iso-2022-jp?B?emRaNU1UNll2YlMrYnpER0JQdW0rZDB2OGgzYkNqRVZhcVFMbXRqSGp2?=
 =?iso-2022-jp?B?eUVCcnBGT08wSWs5K1U5YkJZR0thTVhwSjBIcjVKNi9haVlXYjRFMUo3?=
 =?iso-2022-jp?B?SUVNWHB2WFhwZHJ1d21mZEp1YlhsRmtDRGV5dllDQWtaNEs1WWxBUWV1?=
 =?iso-2022-jp?B?T0FjQzZlQzM4TlJLN1dwWFhPdlBLdzZXRm5RanB2MEduNUtVZmJESEtl?=
 =?iso-2022-jp?B?S29VUjJJTlBnQk1KT2pYTERXUnJ4dnZZVWhHbjZtdWZQVzRRTGh4K3Qw?=
 =?iso-2022-jp?B?QTV3dlZIcHBnc1hrb1psRVRHYjhCbFpzb1hxY21CMDdkMmlRb2NnTy81?=
 =?iso-2022-jp?B?enVSa2g2cEpEQmdSSXJOL0tJSXRVU29aNFZ6Q05kYkw2MGhTcGVHRHA1?=
 =?iso-2022-jp?B?NUVjR004Zy9RWGFaUVpTWUNzaFEwK0pORUJWZnQwVy9mOGNlVmJsVEpx?=
 =?iso-2022-jp?B?N2dVdktLKzE1QnVpLzdvOTA2T2Vsb3pKZW1zVUxBemZ3bFdrUmI5OUpL?=
 =?iso-2022-jp?B?Ly9ucFQveGxwVlp4bHdRREl4Z3NGR0RhZ0pIczUxaXhsVE50R0NFcEN4?=
 =?iso-2022-jp?B?K1h4blJEWjRHenhtVDBWTkVieU9hVDZwTE1ETTFQVTZka2FYbHdHZnNM?=
 =?iso-2022-jp?B?RnRYTXhpbENkeFo5V2VsRkRYM2ZicDNaWFFNbDZINnh4V0s5TndVZ2da?=
 =?iso-2022-jp?B?MGpPbWdQb2I3VlIrOW02OEtKS2pZbW9xVTV2T2hsQjVtWTk4ZGtkQk11?=
 =?iso-2022-jp?B?NGxhNGRMcnVpd29SamhvdUl0SmVrbEV1OHlWQUd6UmN0ZEZ3QlRkMk81?=
 =?iso-2022-jp?B?Y3p4NzhZajZmNGFGVnJ0UmRKYlFVOUREekV0M0FrMjlDWTFtTFNpZXRp?=
 =?iso-2022-jp?B?OTlrVUJxdmg0L3pSRWYvZFN1UFJ2eHlTMVc0emNZYzFXWGR6OE44WWJD?=
 =?iso-2022-jp?B?QjR2aEpqaW81Q3B0N1hWZjlBcS9qeFFZSmcvRFdhVkFOdThlVlpaUFdj?=
 =?iso-2022-jp?B?bFFrTFpmNmhwM085dmVWUGprVWEvejBF?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?U0MwMWtlVzM0YXN4MmU4V0xGTjJIN2hQanFGSUNEUHhrWE9seXdoMWpZ?=
 =?iso-2022-jp?B?NjArejVXVE5OdzRrL2hSRmE4anlGV0RaSzVwaEN0NmEzbC9TcjlaamNH?=
 =?iso-2022-jp?B?RmZQM09mbDJQczkwSk1ub05MaTFjOVlqV2g0ZXc3RmQyelBpZ2FPUnBs?=
 =?iso-2022-jp?B?YllyUjY4alVZUGgwV1M2cFNNc3Y3UDZjTi9HSjMzelViUDNCamJiRXEw?=
 =?iso-2022-jp?B?ODRray9TYlFBN3I0MjlXUWZMOFVIVmVOWG5HQzEzSC9zd2ZQem9ITjNG?=
 =?iso-2022-jp?B?LzBrNHNzRUVVb0h4RExzNEl0bTk3N0hPYmVReXkxemxacEJvNXo5SGFq?=
 =?iso-2022-jp?B?SXI1Y2kyOU9TaUpXd1lENDlCbUcyMFpxazRMN09rNkJxYm14enRWT1di?=
 =?iso-2022-jp?B?Z0twcTJVWFIxYVZHdU5EYU5IdzZ0ZXZ2NENoT0VHajJuUytYNTB3bkll?=
 =?iso-2022-jp?B?UDFHQms5NFczZmsybk1JL2xpYkF1dCtDNFhJcDF3TGNYS2xCV1lZcFlr?=
 =?iso-2022-jp?B?L2twRW9vMEtNczU1R3l1WGJPTFdtUWgrMGhBd1E5KzRIMGRzeTFJVlJj?=
 =?iso-2022-jp?B?emlqS3FyMUQxamZnc1lNTGxyUlVSTWdXL05OcitRTFJaMFVnZ2JyMmc0?=
 =?iso-2022-jp?B?SlpOYi9aV1RybjlPdkVqQ3lIcGxvT3ZVNkNETHJPbk5aakJDd0lBek5W?=
 =?iso-2022-jp?B?cFI4aGFGT1A1T3NUU0hVdEMwcm9GVkNndTlQSDJHczJSSlJONXBsVVV6?=
 =?iso-2022-jp?B?UEhCSVRnTmp5ZTVoTlVvUmoyY2ViaG9jdUlhMVBxMjFhbzE4VlJybnBq?=
 =?iso-2022-jp?B?T0QwbmdoVnRvbW05T3lJTHRzQ2xSWHhwQytnTDg3QlFIL3FTK1d2QUty?=
 =?iso-2022-jp?B?bVZKUHJ5MmtrR25uMHJid1djcVZqektSZkFXd3FJNW1UNjhFUGY4eVdw?=
 =?iso-2022-jp?B?NUI2ZXRUdG9KcDlnQnp2Z2wzRkY5L1pEamp1SXh4R0dzcjlQOWpkbEw0?=
 =?iso-2022-jp?B?eUV4SVY0Ukx6VUdOTkNsY2sza0NZeDl1cFo4cE5EbUVpSytldFQ3d1FL?=
 =?iso-2022-jp?B?ck1saFk5U2FmeG5XYm9zTlY5Z2ZzVE4xd2dQK1ZBMVFkRmI1VlB5TzM2?=
 =?iso-2022-jp?B?Uy9DQ1pDWDQyUFRTWGtTZGQvYVQxc2FickdRdi9McWRtdlYxMlVwVlk1?=
 =?iso-2022-jp?B?OEFmV3luR1FCb2IyMjg3dFltM2xQSWNXaHlWaVBsY0xJcTVWdTVQejh1?=
 =?iso-2022-jp?B?VXpDMm9aTkk1QkNiYzFFMEdLR0pjdWFUbHdibWtBWk45Um5yUnhFMjBr?=
 =?iso-2022-jp?B?QWg3dVdHN2lQQ3hUeGZyOHRGZ1pmTHRuakphWHlqN1BPaXg1VXBQYVhO?=
 =?iso-2022-jp?B?TldhU3oxemJpTEFzVW9jWnVNZXFpTlpvQkNQOU41dWFLZ3Y2T2Mwb0k2?=
 =?iso-2022-jp?B?b25TT1BKOFljbTNTZ2RPalRxR1E1OForQlRvakI2Sk00MXN3TEgydUlK?=
 =?iso-2022-jp?B?UE9iNk1rMlBMTktiWXYveXlCazY0T1poT2ZXTFlsQ0prUW5xWEszcHlR?=
 =?iso-2022-jp?B?c2xXV2NVdU93Y3Bzc0NQbW41YmFCeC9LbFZYajhoaDJDbDZIWkZXZnRo?=
 =?iso-2022-jp?B?clcvZ0pPUk5zWGE1MlBXTDZNbHJoY09Jamg0ZW5aUnJlWEJ1M1FUa1FU?=
 =?iso-2022-jp?B?VGttYVlOdFh2VmxKY1h0aWRUQnFJd0Y5bzQ1TGpiQzYyMkpOSWlTZnJS?=
 =?iso-2022-jp?B?NGlTVXpHSFlCZS9kOVNURndxZXFnOVBZUk5QUE92dHVGUnJIZEJlcEFY?=
 =?iso-2022-jp?B?WHZzWWRFZTNZSERqZjJGZ2NJaEdvbHZEMVNKSVZzS044alZLNFFZWXV4?=
 =?iso-2022-jp?B?Y25rQlV5VWtjampDNmlnQkh5cnVaQ2JTWjBRTlo4UW9JTllnNk1VTVpk?=
 =?iso-2022-jp?B?TlJoNTZHTFBEOFhGbkxlK2FZYWliTEJ5V3V2ZEM4OEtKU2hpRVJMVVAz?=
 =?iso-2022-jp?B?UjdDWGRmQ1dtWkQ1dDAvVWRJeTM0eDQxWjF5ZHp0ZUhjQXdtQkxzcllM?=
 =?iso-2022-jp?B?OWZHM1lkMjdOMlpocU5QcHUxZGJBLzR1YU1oWE5rUjVSRS83TFQxdEp1?=
 =?iso-2022-jp?B?NkYrSHN0UDhyckRYSFJURDVEUldSalMzM3kxOE9hWG5iM0FIVkNvaUZs?=
 =?iso-2022-jp?B?TFcyVDlGcVVkVnFyUExSZmpkZzdMVzJuTUVQT2hFbUROOHNHT3kvSTkz?=
 =?iso-2022-jp?B?aTNLbExJSkVNV2NYRENTNEVES3d5RXNQUDlBZDhhcmcyVTFad1NjZGJ3?=
 =?iso-2022-jp?B?aTBFR2dqNmwzRWRHdmcxWjhjTnRyTFR2Ync9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cdb4fe-c5e5-4d7c-bbf4-08de181e4524
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 01:39:02.0738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Es0dD83kDUe9cxe+bDiEhsYDWWZXDfQY5Fft2uhYNsMY+B6DY2gq7nOYbnurizTSf+9FgmbvJ27vKm9suaKR0vAXnTq0wCFYUnDwQeyrGqFUuq3W55Ioyh2EOPo+0y2B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10232
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Oct 2025 01:39:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20288

Hi,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Thursday, October 30, 2025 5:49 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B$B=
4d>>=1B(B =1B$B?.=1B(B
> =1B$BMN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.to=
shiba>
> Subject: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
>=20
> Hi,
>=20
> This series adds the ICU dts node for the Renesas RZ/V2H SoC, to the
> linux-6.12.y-cip kernel.
>=20
> The ICU driver and its dependencies are already present in the 6.12.y-cip
> branch, having been included earlier as part of the RZ/G3E backporting wo=
rk.
>=20
> For reference, see the related commits:
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h
> =3Dlinux-6.12.y-cip&id=3D3d3a549e2fb073619507de56be14aab242f87b7b
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h
> =3Dlinux-6.12.y-cip&id=3Dae9102da607f85ba0831c6b5af0c0d52d5166f7d
> [3]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h
> =3Dlinux-6.12.y-cip&id=3D69c328745d39318be83b84a7f379009cc574d072
> [4]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h
> =3Dlinux-6.12.y-cip&id=3D9fc198d9b2c292fb089eaaa2a5b679b24d26f072
> [5]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h
> =3Dlinux-6.12.y-cip&id=3D2e7375bcebd154ccf175eed1982d11b8b3c4cb8a
> [6]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h
> =3Dlinux-6.12.y-cip&id=3D1fe131fc74f7fa9d0753fbfb7dbb92483a10ba01
>=20
> The patch was cherry-picked from mainline kernel.
>=20
> Best regards,
> Ovidiu
>=20
> Fabrizio Castro (1):
>   arm64: dts: renesas: r9a09g057: Add ICU node
>=20
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 90
> ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>=20

Thanks for your patch.
Looks good to me. I can apply this patch if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


