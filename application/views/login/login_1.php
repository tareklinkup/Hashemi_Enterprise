<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <title>ASR World Fashion</title>
</head>
<style>
    .login-from {
        position: absolute;
        z-index: 2;
        left: 13%;
        top: 3%;
    }

    .login-image {
        width: 24%;
        margin-left: 58px;
    }

    .img-fluid {
        width: 100%;
    }

    .carousel-indicators li {
        width: 12px;
        height: 14px;
        border-radius: 41px;
        margin-right: 8px;
        background-color: #0000004d;
        margin-left: 1px;
    }
    .carousel-indicators .active{
        background-color: #5cbfc6;
    }

    input {
        background: none;
        line-height: 29px;
        margin: 6px;
        width: 229px;
        border-bottom: 1px solid #c2d4ec;
        border-top: none;
        border-left: none;
        border-right: none;
    }
    input:focus {
        outline: none;
    }
    .form-check-input {
        position: absolute;
        margin-left: -26%;
    }

    .button-login {
        margin-left: 13%;
        margin-top: 50px;
    }

    .button-login button {
        width: 112px;
        border-radius: 31px;
        height: 37px;
        color: white;
        font-weight: 800;
        letter-spacing: 4px;
        background: hsl(185deg 92% 43%);
    }

    .carousel-indicators {
        position: absolute;
        left: 4% !important;
        bottom: 7%;
        z-index: 15;
        right: auto;
    }
    .d-block{
        height: 100vh;
    }
    body{
        height: 100vh;   
    }
    .text {
        margin-left: -237px;
        margin-top: 50px;
        text-align: center;
    }
    .text h2{
        font-size: 21px
    }
    .text p{
        font-size: 15px
    }
    .form-check-label{
        color: hsl(205deg 29% 43%);
    }
</style>

<body>
    <main>
        <img class="d-block body-image img-fluid" src="<?php echo base_url('assets/login_one/')?>bg.png" alt="" style="position: absolute;">
        <div class="container-fluid">

            <div class="login-from">
                <div class="login-image">
                    <img class=" img-fluid" src="<?php echo base_url('assets/login_one/')?>Screenshot_1.png" alt="">
                </div>
                <form class="login100-form validate-form" method="POST" class="login-form" action="<?php echo base_url(); ?>Login/procedure">
                    <p style="color:red;"><?php if (isset($message)) { echo $message;  } ?></p>
                <input type="text" name="user_name" placeholder="Enter username" required><br>
                <?php echo form_error('user_name'); ?>
                <input type="password" name="password" placeholder="Enter password" required>
                <?php echo form_error('password'); ?>
                <div class="form-check">
                    <label class="form-check-label" for="flexRadioDefault1">
                        <input class="form-check-input" type="radio"  id="ckb1"  name="remember-me" 
                            checked>
                        Remeber
                    </label>
                </div>
                <div class="button-login">
                    <button class="btn">LOGIN</button>
                </div>
            </form>
                <div class="text">
                   <h2> ASR World Fashion </h2>
                   <p> ASR World Fashion is largest garment in the Banglasesh. The company is dedicated<br>
                        to excellence in merchandising, product development, production, and logistics.<br>
                         We have earned a reputation throughout the global apparel industry as one<br>
                          of the foremost factories in Bangladesh for our commitment to quality, timely delivery,<br>
                           and total value.</p>
                </div>
            </div>
            <div class="carousel slide" id="main-carousel" data-ride="carousel" style="position: relative;">
                <ol class="carousel-indicators">
                    <li data-target="#main-carousel" data-slide-to="0" class="active"></li>
                    <li data-target="#main-carousel" data-slide-to="1"></li>
                    <li data-target="#main-carousel" data-slide-to="2"></li>
                </ol><!-- /.carousel-indicators -->

                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img class="d-block img-fluid" src="<?php echo base_url('assets/login_one/')?>one.png" alt="">
                        
                    </div>
                    <div class="carousel-item">
                        <img class="d-block img-fluid" src="<?php echo base_url('assets/login_one/')?>two.png" alt="">
                       
                    </div>
                    <div class="carousel-item">
                        <img class="d-block img-fluid" src="<?php echo base_url('assets/login_one/')?>three.png" alt="">
                       
                    </div>
                </div><!-- /.carousel-inner -->

                <a href="#main-carousel" class="carousel-control-prev" data-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                    <span class="sr-only" aria-hidden="true">Prev</span>
                </a>
                <a href="#main-carousel" class="carousel-control-next" data-slide="next">
                    <span class="carousel-control-next-icon"></span>
                    <span class="sr-only" aria-hidden="true">Next</span>
                </a>
            </div><!-- /.carousel -->
        </div><!-- /.container -->

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
            crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
</body>

</html>