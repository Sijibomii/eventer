import createError  from "http-errors";
import express, {Request, Response, NextFunction, Errback}  from "express";
import  indexRouter  from './routes';

var app = express();

app.use('/', indexRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err: Errback , req: Request, res:Response, next: NextFunction) {
  //handle errors here
});
