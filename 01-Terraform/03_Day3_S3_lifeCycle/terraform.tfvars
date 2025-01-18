bucket_name = "ForgTech_bucket"
tags        = ["terraformChamps", "Amer"]
region = "us-east-1"
transition = [
    {days = ["30", "90", "180", "360"]},
    {storage_class = ["STANDARD_IA", "GLACIER", "DEEP_ARCHIVE"]}
]

/*
tags        = [
   {"Environment" = ["terraformChamps"]}, 
   {"Owner" = ["Amer"]}
]
*/